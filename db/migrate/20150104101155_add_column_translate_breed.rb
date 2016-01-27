class AddColumnTranslateBreed < ActiveRecord::Migration
  def change
    add_column :breeds, :translate, :string
  end
end
