class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :coy
      t.string :branch_id
      t.string :branch_name
      t.string :company_id

      t.timestamps
    end
  end
end
