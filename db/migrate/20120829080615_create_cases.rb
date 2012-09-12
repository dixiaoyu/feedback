class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :coy
      t.string :case_id
      t.datetime :incident_date
      t.text :content

      t.timestamps
    end
  end
end
