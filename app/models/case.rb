class Case < ActiveRecord::Base
  attr_accessible :case_id, :content, :coy, :incident_date, :status,
                  :title, :company_id, :company_name, :branch_id,
                  :branch_name, :category, :created_by, :updated_by,
                  :created_at, :updated_at, :poc
end
