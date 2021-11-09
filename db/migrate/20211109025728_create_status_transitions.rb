class CreateStatusTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :status_transitions do |t|
      t.references :ticket, null: false, foreign_key: true
      t.integer :before, null: false
      t.integer :after, null: false
      t.timestamps
    end
  end
end
