class AddSexColumnMypets < ActiveRecord::Migration
  def change
    add_column :mypets, :sex, :integer
  end
end
