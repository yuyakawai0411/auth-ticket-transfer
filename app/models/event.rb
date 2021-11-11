class Event < ApplicationRecord
  has_many :tickets
  
  with_options presence: true do
    validates :name
    validates :owner
  end
  
end
