class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendly_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end