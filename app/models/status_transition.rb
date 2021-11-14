class StatusTransition < ApplicationRecord
  belongs_to :ticket

  with_options presence: true do
    validates :ticket
    validates :before
    validates :after
  end


  def self.ticket_available?
    tickets_available = Ticket.where(status_id: 1).where('availability_date <= ?', Date.today) 
    unless tickets_available.blank?
      tickets_available.each do |ticket| 
        ActiveRecord::Base.transaction do
          status_transition = { ticket_id: ticket.id, before: ticket.status_id, after: 2 }
          StatusTransition.create!(status_transition)
          ticket.update_attribute(:status_id, 2) 
        end
        puts 'ticket status form 1 to 2 updating...'
      end
    end
  end

  def self.ticket_expired?
    tickets_expired = Ticket.where(status_id: 2).where('availability_date < ?', Date.today)
    unless tickets_expired.blank?
      tickets_expired.each do |ticket| 
        ActiveRecord::Base.transaction do
          status_transition = { ticket_id: ticket.id, before: ticket.status_id, after: 3 }
          StatusTransition.create!(status_transition)
          ticket.update_attribute(:status_id, 3) 
        end
        puts 'ticket status form 2 to 3 updating...'
      end
    end
  end

end
