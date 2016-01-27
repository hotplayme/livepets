class CreateTableMypets < ActiveRecord::Migration
  def change
    create_table :mypets do |t|
          t.string   :name
          t.datetime :created_at, null: false
          t.datetime :updated_at, null: false
          t.integer  :user_id
          t.integer  :breed_id
        end
  end
end
