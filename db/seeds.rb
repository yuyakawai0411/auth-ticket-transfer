# ユーザーサンプルデータ
User.create!(id: 1, nickname: 'yuya', email:'yuya@com' ,password: 'yuya',phone_number: '070-1234-5678')
User.create!(id: 2, nickname: 'kinmedai', email:'kinmedai@com' ,password: 'kinmedai',phone_number: '080-1234-5678')

# チケットサンプルデータ
Ticket.create!(id: 1, ticket_name: 'FUJI-ROCK-FESTIVAL-2022', event_date: '2022-8-20',category_id: 1, status_id: 1, user_id: 1)
Ticket.create!(id: 2, ticket_name: 'FUJI-ROCK-FESTIVAL-2022', event_date: '2022-8-20',category_id: 1, status_id: 1, user_id: 1)
Ticket.create!(id: 3, ticket_name: 'ジャンプフェスタ-2020', event_date: '2020-12-15',category_id: 2, status_id: 2, user_id: 1)