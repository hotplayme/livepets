class FixColumnsMypetsToPets < ActiveRecord::Migration[5.0]
  def change
    rename_column :pet_attachments, :mypet_id, :pet_id
  end
end
