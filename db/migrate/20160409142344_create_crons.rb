class CreateCrons < ActiveRecord::Migration
  def change
    create_table :crons do |t|

      t.timestamps null: false
    end
  end
end
