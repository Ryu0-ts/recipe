class AddmaterialTorecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :material, :text
  end
end
