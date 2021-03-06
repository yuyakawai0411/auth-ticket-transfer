class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end
