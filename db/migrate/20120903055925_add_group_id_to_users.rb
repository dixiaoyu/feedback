class AddGroupIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :group_id      
    end
  end
end
