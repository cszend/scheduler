class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :hours
      t.text :description
      t.string :category
      t.integer :listed
      t.integer :status

      t.timestamps
    end
  end
end
