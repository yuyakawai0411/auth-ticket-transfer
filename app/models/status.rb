class Status < ActiveHash::Base
  self.data = [
    { id: 1,  name: '利用不可' },
    { id: 2,  name: '有効期限切れ' },
    { id: 3,  name: '利用可' }
  ]

  include ActiveHash::Associations
  has_many :tickets
end