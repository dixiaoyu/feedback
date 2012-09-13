class CasesController < ApplicationController
  def cus_new_case
    @status=params[:status]
    if @status=="1"
      @agency_id=params[:member].split("@")
      @company_id=@agency_id[0]
      @branch_id=@agency_id[1]
      @company_name=Company.find_by_company_id(@company_id).company_name
      @branch=Branch.find_by_branch_id(@branch_id)
      if @branch.nil?
        @branch_name=""
      else
        @branch_name=@branch.branch_name
      end
    end    
  end
  
  def cus_create_case
    max_case_id=Case.maximum("id")    
    if max_case_id.nil?
      max_id=1   
    else
      max_id=max_case_id+1     
    end
    case_id =Time.now.to_i.to_s + '%08d' % max_id   
        
    s_year=params[:incident]['user(1i)']
    s_month=params[:incident]['user(2i)']
    s_day=params[:incident]['user(3i)']
    incident_date=Date.new(s_year.to_i, s_month.to_i, s_day.to_i).to_s
    
    category=CaseCategory.find(params[:nature]).name
    @case=Case.create(:coy=>"natas",:case_id=>case_id, :incident_date=>incident_date,
                      :company_id=>params[:company_id],:company_name=>params[:company_name],
                      :branch_id=>params[:branch_id],:branch_name=>params[:branch_name],
                      :content=>params[:complaint],:category=>category,
                      :title=>params[:title],:status=>0,
                      :created_at=>Time.now,:created_by=>current_user.user_id,
                      :updated_at=>Time.now, :updated_by=>current_user.user_id)
    redirect_to cus_home_path   
  end
    
  def case_destroy
    @case=Case.find_by_case_id(params[:case_id])
    @case.destroy
    redirect_to case_show_path
  end
  
  def case_detail
    @case=Case.find_by_case_id(params[:case_id])
    if @case.company_id!=nil
      @company=Company.find_by_sql(["select * from companies where company_id=?",@case.company_id])  
      if @case.branch_id!=nil
        @branch=Branch.find_by_sql(["select * from branches where branch_id=?",@case.branch_id])
      end  
    else        
    end
    #@processings=Processing.find_by_sql(["select * from case_process where case_id=? and (reply_to=? or forward_to=? or created_by=?) order by updated_on ASC",params[:case_id],current_user.user_id,current_user.user_id,current_user.user_id])
  end
  
  def case_edit
    @status=params[:status]
    if @status=="1"
      @agency_id=params[:member].split("@")
      @company_id=@agency_id[0]
      @branch_id=@agency_id[1]
      @company_name=Company.find_by_company_id(@company_id).company_name
      @branch=Branch.find_by_branch_id(@branch_id)
      if @branch.nil?
        @branch_name=""
      else
        @branch_name=@branch.branch_name
      end
    end   
    @case=Case.find_by_case_id(params[:case_id])
  end
  
  def case_update
    @case=Case.find_by_case_id(params[:id])
        
    s_year=params[:incident]['user(1i)']
    s_month=params[:incident]['user(2i)']
    s_day=params[:incident]['user(3i)']
    incident_date=Date.new(s_year.to_i, s_month.to_i, s_day.to_i).to_s
    
    category=CaseCategory.find(params[:nature]).name
    @case.update_attributes(:title=>params[:title],:category=>category,:incident_date=>incident_date,:content=>params[:content],
                            :updated_by=>current_user.user_id)
    redirect_to case_detail_path(:case_id=>@case.case_id)                        
  end
  
  def staff_view_case
    if current_user.user_group != "natas" && current_user.user_group != "customer" && current_user.user_group != "admin"
      if current_user.branch_id.nil? || current_user.branch_id==""
        @related_case=Case.where(:company_id=>current_user.company_id)
      else
        @related_case=Case.where(:company_id=>current_user.company_id,:branch_id=>current_user.branch_id)
      end  
      @related_case_ids = []
      @related_case.each do |one|
        @related_case_ids << one.case_id
      end
      @processings=Processing.find(:all, :conditions=>["case_id IN (?)",@related_case_ids])
      @response_cases = []
      @processings.each do |processing|
        @response_cases << processing.case_id  
      end
      @cases=Case.find(:all,:conditions=>["case_id IN (?)",@response_cases],:order => "`created_at` DESC") 
    elsif current_user.user_group == "natas" && current_user.poc=="Y"
      if params[:type] == "filter"
        categ_id=params[:nature]
        if categ_id !=""
          categ=CaseCategory.find_by_id(categ_id).name
          @cases=Case.find(:all,
                    :conditions => ["`category` = ?",categ],
                    :order => "`created_at` DESC"
                    )
        else
          @cases=Case.find(:all,:order => "`created_at` DESC")
        end  
      else
        @cases=Case.find(:all,:order => "`created_at` DESC")
      end   
    elsif current_user.user_group == "natas" && current_user.poc=="N"
      responses=Processing.find(:all,:conditions=>["response_to=?",current_user.user_id]) 
      @case_ids = []  
      responses.each do |response|
        case_id=response.case_id
        @case_ids << case_id
      end  
      @cases=Case.find(:all, :conditions=>["case_id IN (?)",@case_ids],:order=>"`created_at` DESC")   
      @cases_all=Case.find(:all, :conditions=>["case_id NOT IN (?)",@case_ids],:order=>"`created_at` DESC") 
      #@cate_id=GroupCate.find(:all, :conditions=>["`group_id` = ?",current_user.group_id])
      #@cates = []
      #@cate_id.each do |record|
      #  @name=CaseCategory.find_by_id(record.category_id)
      #  @cates << @name.name
      #end
      #@cases=Case.find(:all,:conditions=>["category IN (?)",@cates],:order => "`created_at` DESC")      
    end 

  
=begin
  
   
    @cases.each do |one|
      @case=one
      @responses=Processing.find(:all, :conditions=> ["case_id = ?",one.case_id]) 
      if one.branch_id=="" || one.branch_id.nil?
        @agent_pocs=User.find(:all,:conditions=>["company_id =? and poc=?",one.company_id,"Y"])
      else
        @agent_pocs=User.find(:all,:conditions=>["company_id =? and branch_id =? and poc=?",one.company_id,one.branch_id,"Y"])
      end
      groups=["admin","natas","customer"]
      @agent_others=User.find(:all, :conditions=>["poc=? and user_group NOT IN (?)","Y",groups])
   
      
      @get_infos=User.find(:all,:conditions=>["user_group=?","natas"])      
    end 
=end   
  end
  

end
