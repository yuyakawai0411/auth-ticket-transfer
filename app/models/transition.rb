class Transition < ApplicationRecord
  belongs_to :ticket
  # with_options presence: true do
  #   validates :ticket
  #   validates :sender
  #   validates :recever
  # end
end
