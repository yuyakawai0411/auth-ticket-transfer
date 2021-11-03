class Category < ActiveHash::Base
  self.data = [
    { id: 1,  name: '音楽' },
    { id: 2,  name: 'アニメ' },
    { id: 3,  name: '芸術' },
    { id: 4,  name: 'ゲーム' },
    { id: 5,  name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :tickets
end