class AddAllTagsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :all_tags, :string
  end
end
