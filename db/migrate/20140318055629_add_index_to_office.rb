class AddIndexToOffice < ActiveRecord::Migration
  def change
			add_index :offices, :id, unique: true
			add_index :offices, [:listed, :status]
			add_index :offices, :category
		end
end
