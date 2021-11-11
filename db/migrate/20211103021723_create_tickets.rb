class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_name, null: false
      t.date :event_date, null: false
      t.integer :category_id, null: false
      t.integer :status_id, null: false
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
