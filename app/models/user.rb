class User < ApplicationRecord
  has_many :tickets
  has_many :sender_transition, class_name: 'Transition', :foreign_key => 'sender_id'
  has_many :receiver_transition, class_name: 'Transition', :foreign_key => 'receiver_id'
  
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :phone_number
  end

  def transfer_to_json
    data = {
      id: self.id,
      nickname: self.nickname,
      email: self.email,
      phone_number: self.phone_number
    }
  end

end
