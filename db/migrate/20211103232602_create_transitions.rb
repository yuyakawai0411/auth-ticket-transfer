class CreateTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :transitions do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
