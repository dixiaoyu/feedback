class Processing < ActiveRecord::Base
  attr_accessible :case_id, :coy, :reply_content,
                  :created_by, :updated_by, :response_type,
                  :response_to, :attachment, :service_standard
end
