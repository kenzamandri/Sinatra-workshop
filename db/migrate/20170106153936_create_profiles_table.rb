class CreateProfilesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.integer :age
      t.integer :user_id
    end
  end
end
