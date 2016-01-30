class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :user_id

      t.integer :noticeable_id
      t.string  :noticeable_type

      t.timestamps null: false
    end
    add_index :notices, :user_id
    add_index :notices, [:noticeable_id, :noticable_type]
  end
end
