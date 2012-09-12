class CreateCaseCategories < ActiveRecord::Migration
  def change
    create_table :case_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
