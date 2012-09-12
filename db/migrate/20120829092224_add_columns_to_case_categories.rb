class AddColumnsToCaseCategories < ActiveRecord::Migration
  def change
    change_table :case_categories do |t|
      t.string :coy
      t.string :created_by
      t.string :updated_by
    end
  end
end
