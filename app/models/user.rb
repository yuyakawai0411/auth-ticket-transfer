class User < ApplicationRecord
  has_many :tickets
  has_many :sender_transition, class_name: 'Transition', :foreign_key => 'sender_id'
  has_many :recever_transition, class_name: 'Transition', :foreign_key => 'recever_id'
  
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :phone_number
  end

end
