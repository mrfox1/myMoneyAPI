class RenameColumnInCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :type, :record_type
  end
end
