class User < ApplicationRecord
  has_many :tickets
  
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :phone_number
  end

end
