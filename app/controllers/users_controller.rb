class UsersController < ApplicationController
  def new
    @title="signup"
    @user=User.new
  end
  
  def create
    if params[:password].empty?||params[:password_confirmation].empty?||params[:password] !=params[:password_confirmation]
      redirect_to signup_path(:p=>"nm")#not match
    elsif params[:password].length<6
      redirect_to signup_path(:p=>"ts")#too short  
    elsif
      @user=User.new
      @user.coy="natas"
      @user.user_id=params[:user_id]
      @user.email=params[:email]
      @user.pwd=User.encrypt_password(params[:password])
      #@user.last_login=Time.now
      @user.user_group="customer"
      @user.created_by=params[:user_id]
      @user.updated_by=params[:user_id]
      if @user.save    
        redirect_to signin_path       
      else
        render 'new'
      end  
    end
  end
  
  def cus_detail
    @user=User.find_by_user_id(current_user.user_id)   
  end
  
  def cus_home
    if params[:type] == "filter"
      categ_id=params[:nature]
      if categ_id !=""
      categ=CaseCategory.find_by_id(categ_id).name      
        @cases=Case.find(:all,
                :conditions => ["`created_by` = ? and `category` = ?", current_user.user_id, categ],
                :order => "`created_at` DESC"
                )
      else
        @cases=Case.find(:all,
               :conditions => ["`created_by` = ?", current_user.user_id],
               :order => "`created_at` DESC"
               )          
      end            
    else
      @cases=Case.find(:all,
           :conditions => ["`created_by` = ?", current_user.user_id],
           :order => "`created_at` DESC"
           ) 
    end 
    @user=User.find_by_user_id(current_user.user_id) 
  end
  
  def cus_edit
    @user=current_user
  end
  
  def cus_update
    @user=User.find_by_user_id(params[:user_id])
    @user.first_name=params[:users][:first_name]
    @user.last_name=params[:users][:last_name]
    @user.email=params[:users][:email]
    @user.contact=params[:users][:contact]
    @user.address=params[:users][:address]

    if params[:gender]=="1"
      @user.gender="Ms"
    else
      @user.gender="Mr"  
    end
    
    if @user.save      
      redirect_to cus_detail_path(:user_id=>current_user.user_id)
    else 
      render 'cus_edit'     
    end        
  end
  
  def reset_pwd    
  end
  
  def update_pwd
    current_pwd=User.encrypt_password(params[:users][:current_pw])
    if current_pwd==current_user.pwd
      if params[:users][:password]==params[:users][:password_confirmation]
        if(params[:users][:password].length<6)
          #@notice="Your password length is less than 6 characters"  
          redirect_to reset_pwd_path(:n=>"2")
        else  
          mbr_pw=User.encrypt_password(params[:users][:password])
          current_user.update_attributes(:pwd=>mbr_pw, :pwd_changed=>Time.now, :updated_by=>current_user.user_id)        
          #reset_session
          session[:password]=params[:users][:password]
          #redirect_to pwdsuccess_path()
          if current_user.user_group=="customer"
            redirect_to cus_detail_path(:user_id=>current_user.user_id)
          elsif  current_user.user_group=="natas" 
            redirect_to natas_home_path(:user_id=>current_user.user_id)
          elsif  current_user.user_group=="member" 
            redirect_to mbr_home_path(:user_id=>current_user.user_id) 
          end  
        end  
      else
        #@notice="Your password confirmation doesn't match"  
        redirect_to reset_pwd_path(:n=>"0")          
      end  
    else
      #@notice="The current password is incorrect"
      redirect_to reset_pwd_path(:n=>"1")  
    end    
  end
  
  def cus_get_agency
    @agencies=User.find_by_sql("select m.company_id,m.company_name,b.branch_id,branch_name from companies m left join branches b 
                                  on m.company_id=b.company_id")           
  end
  
  def natas_add_new_user
    if params[:group]=="member"   
      if current_user.branch_id.nil? || current_user.branch_id==""  
        @groups=Group.where(:group => current_user.company_id)    
      else
        @groups=Group.where(:group => current_user.company_id, :branch=>current_user.branch_id)        
      end  
    else 
      @groups=Group.where(:group => "natas")
    end
  end
  
 def natas_create_new_user
    user_check=User.find_by_user_id(params[:user_id])    
    if user_check.nil?  
      if params[:pwd].length>=6 
        if params[:pwd]==params[:re_pwd] 
          @user = User.new()
          @user.coy="natas"
          @user.user_id=params[:user_id]
          @user.pwd=User.encrypt_password(params[:pwd])
          @user.first_name=params[:first_name]
          @user.last_name=params[:last_name]
          @user.email=params[:email]
          @user.contact=params[:contact]
          @user.title=params[:title]
          if params[:level]=="1"
            @user.level="Junior"
          else
            @user.level="Senior"  
          end
          if params[:poc]=="1"
            @user.poc="N"
          else
            @user.poc="Y"  
          end
          if params[:gender]=="1"
            @user.gender="MR"
          else
            @user.gender="MS"  
          end                    
          #@user.last_login=Time.now
          if current_user.user_group=="natas"
            @user.user_group="natas"
          elsif current_user.user_group !="natas" && current_user.user_group !="customer" && current_user.user_group !="admin" 
            @user.user_group=current_user.user_group
            @user.company_name=current_user.company_name
            @user.company_id=current_user.company_id
            @user.branch_name=current_user.branch_name
            @user.branch_id=current_user.branch_id
          end  
          @user.group_id=Group.find_by_id(params[:group]).group_id
          @user.created_by=current_user.user_id
          @user.updated_by=current_user.user_id
          if @user.save
            if current_user.user_group=="natas"
              redirect_to natas_home_path(:user_id=>current_user.user_id)
            elsif current_user.user_group !="natas" && current_user.user_group !="customer" && current_user.user_group !="admin"
              redirect_to mbr_home_path(:user_id=>current_user.user_id)
            end    
          else
            render 'natas_add_new_user'
          end 
        else
          redirect_to natas_add_new_user_path(:error=>"pwd") 
        end    
      else
        redirect_to natas_add_new_user_path(:error=>"length") 
      end  
    else
      redirect_to natas_add_new_user_path(:error=>"user")
    end      
  end  
  
end
