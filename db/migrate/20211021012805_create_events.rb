class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :owner, null: false 
      t.date :event_date, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
