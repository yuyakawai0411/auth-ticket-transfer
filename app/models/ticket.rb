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
    validates :user
  end

  def ticket_exist?
    if self.blank?
      data = { status: 404, message: '存在しないチケットです' } 
    end
  end

  def transfer_to_json
    @data = []
    if self.is_a?(ActiveRecord::Relation)
      self.each do |ticket|
        @data << {
          id: ticket.id,
          ticket_name: ticket.ticket_name,
          event_date: ticket.event_date,
          category_id: ticket.category.name,
          status_id: ticket.status.name,
          user_id: ticket.user.nickname,
          created_at: Time.parse(ticket.created_at.to_s).to_i
        }
      end
    else
      @data << {
        id: self.id,
        ticket_name: self.ticket_name,
        event_date: self.event_date,
        category_id: self.category.name,
        status_id: self.status.name,
        user_id: self.user.nickname,
        created_at: Time.parse(self.created_at.to_s).to_i
      }
    end
  end

end
