class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.text :description
      t.string :phone_number, null: false, default: ""

      t.timestamps
    end
  end
end
