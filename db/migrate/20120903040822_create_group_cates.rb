class CreateGroupCates < ActiveRecord::Migration
  def change
    create_table :group_cates do |t|
      t.string :coy
      t.string :group_id
      t.string :category_id
      t.string :view
      t.string :process
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
