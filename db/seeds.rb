# イベントサンプルデータ
Event.create!(id: 1, name: 'FUJI-ROCK-FESTIVAL-2022', owner:'SMASH', date: '2022-8-20', category_id: 1 )
Event.create!(id: 2, name: 'ジャンプフェスタ-2020', owner:'集英社', date: '2020-12-15',category_id: 2 )

# ユーザーサンプルデータ
User.create!(id: 1, nickname: 'yuya', email:'yuya@com' ,password: 'yuya',phone_number: '070-1234-5678')
User.create!(id: 2, nickname: 'kinmedai', email:'kinmedai@com' ,password: 'kinmedai',phone_number: '080-1234-5678')

# チケットサンプルデータ
Ticket.create!(id: 1, availabilty_date: '2022-8-19', status_id: 1, user_id: 1, event_id: 1)
Ticket.create!(id: 2, availabilty_date: '2022-8-19', status_id: 1, user_id: 1, event_id: 1)
Ticket.create!(id: 3, availabilty_date: '2020-12-14', status_id: 1, user_id: 1, event_id: 2)
Ticket.create!(id: 4, availabilty_date: '2020-12-14', status_id: 1, user_id: 1, event_id: 2)