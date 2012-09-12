class ProcessingsController < ApplicationController
  def natas_select_staff
    if params[:selected].nil?
      redirect_to natas_view_case_path(:error=>"staff")
    end
    
    if params[:type]=="filter"
      if params[:selected] !=nil
        @cate=Case.find_by_case_id(params[:selected][0]).category          
        cate_id=CaseCategory.find_by_name(@cate).id 
        @records=GroupCate.where(:category_id=>cate_id,:process=>"yes")
        @groups = []
        @records.each do |record|
          @groups << record.group_id
        end
        @staffs=User.find(:all,:conditions=>["group_id IN (?)",@groups])   
      end
    else
      if params[:selected] !=nil
        @cate=Case.find_by_case_id(params[:selected][0]).category          
        cate_id=CaseCategory.find_by_name(@cate).id 
        params[:selected].each do |select|
          series_cate=Case.find_by_case_id(select).category          
          series_cate_id=CaseCategory.find_by_name(series_cate).id 
          if series_cate_id !=cate_id
            redirect_to natas_view_case_path(:error=>"cate")
          end
        end 
        @records=GroupCate.where(:category_id=>cate_id,:process=>"yes")
        @groups = []
        @records.each do |record|
          @groups << record.group_id
        end
        @staffs=User.find(:all,:conditions=>["group_id IN (?)",@groups])        
      end
    end 
  end
  
  def natas_assign_case
    cases=params[:seleted_items].split
    cases.each do |one|
      processing=Processing.new(:coy=>"natas", :case_id=>one, :reply_content=>"Please process this feedback.",
                                :response_type=>"reply", :response_to=>params[:res_staff],
                                :created_by=>current_user.user_id,
                                :updated_by=>current_user.user_id)
      if processing.save
        case_seleted=Case.find_by_case_id(one)
        case_seleted.update_attributes(:status=>"1",:poc=>params[:res_staff],:updated_by=>current_user.user_id)
      end                            
    end   
    redirect_to natas_view_case_path
  end
  
  def case_processing
    @title="case_processing"
    groups=["admin","natas","customer"]
    @case_id=params[:case_id]
    @case=Case.find_by_case_id(params[:case_id])
    if current_user.user_group=="customer"
      @responses=Processing.find(:all, :conditions=> ["case_id = ? and response_to=?",params[:case_id],current_user.user_id])
      staff_ids=[]
      @responses.each do |response|
        if staff_ids.include?(response.created_by)==false
          staff_ids << response.created_by
        end 
      end
      @staffs=User.find(:all,:conditions=>["user_id IN (?)",staff_ids])      
    #elsif groups.include?(current_user.user_group)  
    elsif current_user.user_group=="natas"
      if @case.branch_id=="" || @case.branch_id.nil?
        @agent_pocs=User.find(:all,:conditions=>["company_id =? and poc=?",@case.company_id,"Y"])
      else
        @agent_pocs=User.find(:all,:conditions=>["company_id =? and branch_id =? and poc=?",@case.company_id,@case.branch_id,"Y"])
      end 
    @agent_others=User.find(:all, :conditions=>["poc=? and user_group NOT IN (?)","Y",groups])  
    #@natas_staffs=User.find(:all,:conditions=>["user_group=? and level=?","natas","Junior"])
    @get_infos=User.find(:all,:conditions=>["user_group=?","natas"])
    @responses=Processing.find(:all, :conditions=> ["case_id = ?",params[:case_id]]) 
    elsif groups.include?(current_user.user_group)==false
      @responses=Processing.find(:all, :conditions=> ["case_id = ?",params[:case_id]])   
      if current_user.branch_id=="" || current_user.branch_id.nil?
        @get_infos=User.find(:all,:conditions=>["company_id =?",current_user.company_id])
      else
        @get_infos=User.find(:all,:conditions=>["company_id =? and branch_id =? and poc=?",current_user.company_id,current_user.branch_id,"Y"])
      end 
      @natas_staffs=User.find(:all,:conditions=>["user_group=? and level=?","natas","Junior"]) 
    end    
  end
  
  def create_response
    @case_id=params[:case_id]
    @case=Case.find_by_case_id(@case_id)
    @type=params[:type]
    @response_to=params[:response_to]
    response_to = Case.find_by_case_id(@case_id).created_by    

    if @type =="comment"
      processing=Processing.new(:coy=>"natas", :case_id=>@case_id, :reply_content=>params[:content],
                            :response_type=>@type, 
                            :created_by=>current_user.user_id,
                            :updated_by=>current_user.user_id)   
    elsif @type=="reply"
      processing=Processing.new(:coy=>"natas", :case_id=>@case_id, :reply_content=>params[:content],
                            :response_type=>@type, :response_to=>@case.created_by,
                            :created_by=>current_user.user_id,
                            :updated_by=>current_user.user_id)                           
    elsif 
      processing=Processing.new(:coy=>"natas", :case_id=>@case_id, :reply_content=>params[:content],
                            :response_type=>@type, :response_to=>@response_to,
                            :created_by=>current_user.user_id,
                            :updated_by=>current_user.user_id)                              
    end                          
    if processing.save
      if Processing.find(:all,:conditions=>["case_id=?",@case_id]).count==1
        @case.update_attributes(:status=>"1")
      end
      redirect_to case_processing_path(:case_id=>@case_id)
    end                      
  end
  
  def forward_contactlist
    @processing=params[:processing]
    if params[:processing] !=nil
      @case_id=Processing.find_by_id(params[:processing]).case_id
    else
      @case_id=params[:case]  
    end
    @case=Case.find_by_case_id(@case_id)
    case_cate_id=CaseCategory.find_by_name(@case.category).id
    @case_company=@case.company_id
    @case_branch=@case.branch_id
    #Interior Users
    groups=Group.where(:group =>current_user.user_group)
    group_ids=[]
    groups.each do |group|
      group_ids << group.group_id 
    end
    
    group_cates=GroupCate.find(:all,:conditions=>["category_id=? and group_id IN (?) ",case_cate_id,group_ids])
    group_involved_ids=[]
    group_cates.each do |group_cate|
      group_involved_ids << group_cate.group_id 
    end 
        
    @interior_users=User.find(:all, :conditions=>["group_id IN (?)",group_involved_ids])
    
    #Agency Users  
    if @case_branch.nil? || @case_branch==""
      @users=User.find(:all, :conditions=>["company_id =?",@case_company])
    else
      @users=User.find(:all, :conditions=>["company_id =? and branch_id = ?",@case_company,@case_branch])    
    end  
  
    user_groups=[]
    @users.each do |user|
      user_group_cates=GroupCate.find(:all, :conditions=>["category_id=? and group_id=?",case_cate_id,user.group_id])
      if user_group_cates !=nil
        user_groups << user.user_id
      end
    end
    @agency_users=User.find(:all, :conditions=>["user_id IN (?)",user_groups]) 
  end
  
  def cus_evaluate_service
    standard=Processing.find(params[:processing_id])
    standard.update_attributes(:service_standard=>params[:standard])
    redirect_to case_processing_path(:case_id=>params[:case_id])
  end
end
