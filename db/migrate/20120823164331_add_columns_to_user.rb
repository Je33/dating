class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :name, :string
    add_column :users, :sex, :integer
    add_column :users, :age, :integer
    add_column :users, :search_sex, :integer
    add_column :users, :search_age_from, :integer
    add_column :users, :search_age_to, :integer
  end
end
