class AddColumnsToProcessings < ActiveRecord::Migration
  def change
    change_table :processings do |t|
      t.string :response_type
      t.string :response_to
      t.string :attachment
      t.string :created_by
      t.string :updated_by
    end
  end
end
