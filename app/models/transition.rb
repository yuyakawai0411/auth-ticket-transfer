class Transition < ApplicationRecord
  belongs_to :ticket
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
