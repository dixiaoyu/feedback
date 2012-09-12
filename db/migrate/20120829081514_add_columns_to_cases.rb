class AddColumnsToCases < ActiveRecord::Migration
  def change
    change_table :cases do |t|
      t.string :category
      t.string :status
      t.string :title
      t.string :company_name
      t.string :company_id
      t.string :branch_name
      t.string :branch_id
      t.string :created_by
      t.string :updated_by
    end
  end
end
