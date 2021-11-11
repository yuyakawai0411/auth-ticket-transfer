class Event < ApplicationRecord
  has_many :tickets
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :name
    validates :owner
  end

  def transfer_to_json
    data = {
      id: self.id,
      name: self.name,
      owner: self.owner
    }
  end

end
