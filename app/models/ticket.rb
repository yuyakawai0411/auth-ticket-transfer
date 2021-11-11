class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :transitions
  has_many :status_transitions
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
  validate :user_available?
  validate :date_after_today
  

  def transfer_to_json
    data = {
      id: self.id,
      ticket_name: self.ticket_name,
      event_date: self.event_date,
      category_id: self.category.name,
      status_id: self.status.name,
      user_id: self.user.nickname,
      created_at: Time.parse(self.created_at.to_s).to_i
    }
  end

  private
  def user_available?
    user = User.find_by(id: self[:user_id])
    if user.blank?
      errors.add(:user_id, "doesn't exist")
    end
  end

  def date_after_today
    if self[:event_date].blank?
      errors.add(:event_date, "can't be blank")
    elsif self[:event_date] < Date.today
      errors.add(:event_date, "doesn't before today")
    end
  end

end
