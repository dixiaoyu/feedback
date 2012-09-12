class AddPocToCases < ActiveRecord::Migration
  def change
    add_column :cases, :poc, :string
  end
end
