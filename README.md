# アプリの前提条件
- ユーザーはすでに複数枚のチケットを所持している
- チケットの譲渡には金銭的やり取りは発生しない
- チケットの受け手には、譲渡の拒否権はない
- ユーザーログイン等の認証機能は必要としない
- 譲渡履歴はユーザー→チケット→譲渡履歴の順に探索することを想定
  
# API仕様
## ユーザー機能
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users

### レスポンス
- ユーザー情報
- HTTPステータス200

## ユーザー機能
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users/:id

### レスポンス
- ユーザー情報
- HTTPステータス200

## 所有チケットの照会機能
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users/:id/tickets

### レスポンス
- ユーザーが所有している全てのチケット情報
- HTTPステータス200

## 所有チケットの照会機能
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users/:id/tickets/:id

### レスポンス
- ユーザーが所有している全てのチケット情報
- HTTPステータス200

## 所有チケットの譲渡機能
### リクエスト
- HTTP:POST
- Body:recever
- http://user/:id/tickets/:id/transtions
### レスポンス
- ユーザーが譲渡したチケット情報
- HTTPステータス201

## 譲渡履歴の照会機能
### リクエスト
- HTTP:GET
- Body:なし 
- http://user/:id/tickets/:id/transtions
### レスポンス
- 全ユーザーの譲渡履歴
- HTTPステータス200

## 譲渡履歴の照会機能
### リクエスト
- HTTP:GET
- Body:なし 
- http://user/:id/tickets/:id/transtions/:id
### レスポンス
- 全ユーザーの譲渡履歴
- HTTPステータス200

# 実装した案、実装しなかった案
## 修正箇所
- [X] Rspecにテストケースを全て書く
- [X]テストexampleの粒度を細かくする
- [X]user,ticketのrequestテストをパスさせる
- [X]URLを全て修正する
- [X]transitionテーブルは外部キーでアソシエーションする(ticket_idがticketに、user_idがsenderに入るようにする)
- [X]transitionの外部キーはuser_idとticket_idは継承するようにする
  
## ユーザー譲渡機能修正箇所
- []http://user/:id/tickets/:id/transtionsの譲渡履歴は昇順で表示する
- []存在しないidが入力された時の例外処理をコントローラに記述する
- []ユーザーが所持していないチケットは送信できないようにする
- []自分自身にチケットを送れないようにする
- []http://users/:id/tickets/:idでuser_idに紐付かないticket_idは検索してもエラーになる容姿する
- []http://user/:id/tickets/:id/transtionsのidは配列で渡せるようにし、複数のチケットを一斉送信できるようにする
- []ticketsテーブルのstatus_idは他の人が見てわかるようにする(テーブル設計状態遷移)
- update_attributeはバリデーション検証がないため、なるべく使わないようにする

## リファクタリング
- []譲渡ロジック(withdraw&deposit)をモデルに移す
- []transfer_jsonロジックをメタプロで共通化できないか考える

## 実装した案
- イベント系のチケットを想定しており、イベント当日にチケットのステータスが使用可となる

## 実装しなかった案
- チケット譲渡を配列で複数選択できるようにする
  - メリット:
  - デメリット
- チケットの受け手が譲渡を承認するかを選択できる
  - メリット:
  - デメリット:
- 自分と繋がりのある人のみチケットを譲渡できる
  - メリット:譲渡ミスのデメリットを最小限に抑えられる
  - デメリット:繋がり申請をしないといけない
- チケットがイベント日時直前に有効になる
  - メリット:
  - デメリット:
- チケットを複数持っている場合は、カウントする



# テスト実施に使用した時間
- 設計:4h
- コーディング:8h
- リファクタリング:

# 使用方法
- rails db:create
- rails db:seed


# ユーザーサイド
## あるユーザーが所有するチケットを表示
- http://user/:id/tickets
- @user = User.find_by(id: params[:id])
- @tickets = @user.ownwer

## あるユーザーがあるユーザーにチケットを譲渡する
- http://user/:id/tickets/:id/transfer

# 管理サーバー
## 誰が誰に譲渡したかをわかるようにする
- http://tickets/:id/tracker