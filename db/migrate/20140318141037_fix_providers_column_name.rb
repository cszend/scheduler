class FixProvidersColumnName < ActiveRecord::Migration
  def change
		rename_column :providers, :office, :office_id
  end
end
