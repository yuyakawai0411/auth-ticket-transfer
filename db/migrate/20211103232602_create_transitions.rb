class CreateTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :transitions do |t|
      t.integer :ticket, null: false
      t.integer :sender, null: false
      t.integer :recever, null: false
      t.timestamps
    end
  end
end
