class AddColumsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :coy, :defailt=>"natas"
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact
      t.string :gender
      t.string :address
      t.string :user_group      
      t.string :title
      t.string :level
      t.datetime :last_login
      t.datetime :pwd_changed
      t.string :poc
      t.string :company_name
      t.string :company_id
      t.string :branch_name
      t.string :branch_id
      t.string :created_by
      t.string :updated_by
    end
  end 

end
