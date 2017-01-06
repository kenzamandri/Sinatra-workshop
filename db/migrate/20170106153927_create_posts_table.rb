class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :text
      t.integer :user_id
      t.integer :profile_id
    end
  end
end
