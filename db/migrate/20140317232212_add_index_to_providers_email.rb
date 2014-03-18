class AddIndexToProvidersEmail < ActiveRecord::Migration
  def change
		add_index :providers, :email, unique: true
		add_index :providers, [:office, :role]
  end
end
