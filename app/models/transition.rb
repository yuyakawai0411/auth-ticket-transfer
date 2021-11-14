class Transition < ApplicationRecord
  belongs_to :ticket
  belongs_to :sender, class_name: 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, class_name: 'User', :foreign_key => 'receiver_id'

  with_options presence: true do
    validates :ticket
    validates :sender_id
    validates :receiver_id
  end
  validate :receiver_available?

  def transfer(ticket)
    ActiveRecord::Base.transaction do
      ticket.update_attribute(:user_id, self[:receiver_id]) 
      self.save!
    end
  end

  def transfer_to_json
    data = {
      id: self.id,
      ticket_id: self.ticket.event.name,
      sender_id: self.sender.nickname,
      receiver_id: self.receiver.nickname,
      created_at: Time.parse(self.created_at.to_s).to_i
    }
  end

  private
  def receiver_available?
    receiver = User.find_by(id: self[:receiver_id])
    if receiver.blank?
      errors.add(:receiver_id, "doesn't exist")
    elsif self[:sender_id] == self[:receiver_id]
      errors.add(:receiver_id, "can't select myself")
    end
  end

end
