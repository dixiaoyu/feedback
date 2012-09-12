class AddColumnsToBranches < ActiveRecord::Migration
  def change
    change_table :branches do |t|
      t.integer :no_of_year
      t.integer :qty_of_employee
      t.string :rcb_no
      t.string :ta_licence_no
      t.string :lata_no
      t.string :contact_person
      t.string :contact_no
      t.string :contact_email
      t.string :address
      t.string :created_by
      t.string :updated_by
    end
  end
end
