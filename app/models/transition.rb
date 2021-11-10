class Transition < ApplicationRecord
  belongs_to :ticket
  belongs_to :sender, class_name: 'User', :foreign_key => 'sender_id'
  belongs_to :recever, class_name: 'User', :foreign_key => 'recever_id'

  with_options presence: true do
    validates :ticket
    validates :sender_id
    validates :recever_id
  end
  validate :recever_available?

  def transfer(ticket)
    ActiveRecord::Base.transaction do
      ticket.update_attribute(:user_id, self[:recever_id]) 
      self.save!
    end
  end

  def transfer_to_json
    data = {
      id: self.id,
      ticket_id: self.ticket.ticket_name,
      sender_id: self.sender.nickname,
      recever_id: self.recever.nickname,
      created_at: Time.parse(self.created_at.to_s).to_i
    }
  end

  private
  def recever_available?
    recever = User.find_by(id: self[:recever_id])
    if recever.blank?
      errors.add(:recever_id, "doesn't exist")
    elsif self[:sender_id] == self[:recever_id]
      errors.add(:recever_id, "can't select myself")
    end
  end

end
