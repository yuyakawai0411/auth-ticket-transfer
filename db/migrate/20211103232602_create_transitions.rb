class CreateTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :transitions do |t|
      t.string :ticket, null: false
      t.string :sender, null: false
      t.string :recever, null: false
      t.timestamps
    end
  end
end
