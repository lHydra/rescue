class AddThumbToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :thumb, :string
  end
end
