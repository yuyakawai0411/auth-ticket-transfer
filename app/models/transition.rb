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

  def self.transfer(transfer, ticket)
    ActiveRecord::Base.transaction do
      ticket.update_attribute(:user_id, transfer[:recever_id]) 
      transfer.save!
    end
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
