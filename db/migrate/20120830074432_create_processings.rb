class CreateProcessings < ActiveRecord::Migration
  def change
    create_table :processings do |t|
      t.string :coy
      t.string :case_id
      t.text :reply_content

      t.timestamps
    end
  end
end
