class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.date :availability_date, null: false
      t.integer :status_id, null: false
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
