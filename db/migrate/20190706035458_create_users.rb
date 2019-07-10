class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.text :profile
      t.string :user_image
      t.string :email

      t.timestamps
    end
  end
end
