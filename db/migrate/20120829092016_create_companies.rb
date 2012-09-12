class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :coy
      t.string :company_id
      t.string :company_name

      t.timestamps
    end
  end
end
