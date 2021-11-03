class Ticket < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
    validates :ticket_name
    validates :event_date
    validates :category_id
    validates :status_id
  end
end
