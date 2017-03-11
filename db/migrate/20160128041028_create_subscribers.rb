class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id

      t.integer :subscribable_id
      t.string  :subscribable_type

      t.timestamps null: false
    end
    add_index :subscribers, :user_id
    add_index :subscribers, [:subscribable_id, :subscribable_type]
  end
end
