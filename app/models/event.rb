class Event < ApplicationRecord
  has_many :tickets
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :name
    validates :owner
    validates :date
    validates :category_id, numericality: { greater_than: 0, less_than: 6 }
  end

  def transfer_to_json
    data = {
      id: self.id,
      name: self.name,
      owner: self.owner,
      date: self.date,
      category_id: self.category.name
    }
  end

end
