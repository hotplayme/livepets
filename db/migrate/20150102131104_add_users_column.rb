class AddUsersColumn < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name,  :string
  	add_column :users, :sex, 		:string
  	add_column :users, :day,		:integer
  	add_column :users, :month,      :integer
  	add_column :users, :year,       :integer
  	add_column :users, :city,		:string
  	add_column :users, :country,    :string
  end
end
