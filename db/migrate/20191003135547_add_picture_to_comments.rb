class AddPictureToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :picture, :string
  end
end
