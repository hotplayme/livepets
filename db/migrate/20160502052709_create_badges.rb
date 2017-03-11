class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :slug
      t.text   :desc
      t.string :metal
      t.timestamps null: false
    end
  end
end
