class Transition < ApplicationRecord
  belongs_to :ticket
  belongs_to :sender, class_name: 'User', :foreign_key => 'sender_id'
  belongs_to :recever, class_name: 'User', :foreign_key => 'recever_id'
  # with_options presence: true do
  #   validates :ticket
  #   validates :sender
  #   validates :recever
  # end

  def self.transfer(transfer, ticket)
    ActiveRecord::Base.transaction do
      ticket.update_attribute(:user_id, transfer[:recever_id]) 
      transfer.save!
    end
  end

end
