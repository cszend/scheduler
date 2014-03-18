class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :username
      t.string :email
      t.integer :role
      t.integer :access
      t.string :password_digest
      t.integer :office

      t.timestamps
    end
  end
end
