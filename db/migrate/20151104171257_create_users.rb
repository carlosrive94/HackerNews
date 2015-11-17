class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userName
      t.string :password
      t.integer :karma
      t.text :about
      t.string :uid

      t.timestamps null: false
    end
  end
end
