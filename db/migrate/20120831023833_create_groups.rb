class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :coy
      t.string :group_id
      t.string :group
      t.string :dept
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
