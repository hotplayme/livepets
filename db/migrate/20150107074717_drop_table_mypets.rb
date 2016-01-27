class DropTableMypets < ActiveRecord::Migration
  def change
    drop_table :mypets
  end
end
