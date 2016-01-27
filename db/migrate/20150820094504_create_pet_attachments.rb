class CreatePetAttachments < ActiveRecord::Migration
  def change
    create_table :pet_attachments do |t|
      t.string :file
      t.boolean :main
      t.integer :mypet_id
      t.timestamps null: false
    end
  end
end
