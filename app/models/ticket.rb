class Ticket < ApplicationRecord
  belongs_to :user
  has_many :transitions
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status

  with_options presence: true do
    validates :ticket_name
    validates :event_date
    validates :category_id, numericality: { greater_than: 0, less_than: 6 }
    validates :status_id, numericality: { greater_than: 0, less_than: 4 }
  end


  # def self.wisdraw(ticket)
  #   wisdraw_ticket = Ticket.find_by(id: ticket)
  #   binding.pry
  #   wisdraw_ticket.destroy
  # end

  # def self.deposit(ticket, recever)
  #   deposit_ticket = Ticket.find_by(id: ticket)
  #   get_ticket = { ticket_name: deposit_ticket.ticket_name,
  #                  event_date: deposit_ticket.event_date,
  #                  category_id: deposit_ticket.category_id,
  #                  status_id: deposit_ticket.status_id,
  #                  user_id: recever
  #   }
  #   Ticket.create(get_ticket)
  # end

end
