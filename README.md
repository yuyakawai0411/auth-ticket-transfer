# 課題内容
あるユーザが複数枚の電子チケットを購入し、家族や友人へ譲渡することがある。
このケースを想定して、電子チケットの譲渡機能のAPI群を作成せよ。

# 実装するAPI
- あるユーザが所有するチケットの情報を取得できる API 
- 譲渡機能を実現するために必要な API 群
- 誰が誰に譲渡したかを、あとから追跡できる API

# アプリの前提条件(自分で設定)
- ユーザーはすでに複数枚のチケットを所持している
- チケットの譲渡には金銭的やり取りは発生しない
- チケットの受け手には、譲渡の拒否権はない
- ユーザーログイン等の認証機能は必要としない
- 譲渡履歴はユーザー→チケット→譲渡履歴の順に探索することを想定

# 現在の懸念点
## ソースコード
- []trasitions controllerのリダイレクトが複雑ではないか？
  - 予期せぬリクエストでエラーになる設計をしていないか？
- []外部キーには、マイグレーションファイルでnull false制約、モデルでpresentのバリデーションを宣言すべきか？
- []その他、必要な機能の実装もれや設計ミスはないか？

## Rspec
- []modelのバリデーションテストにて外部キーのnullテストをすべきか？
  - FactoryBotでアソシエーョン設定しているため、外部キーに直接nullを挿入することができない
- []transition requestテストのexampleの粒度が細かすぎないか？

# API仕様
## ユーザ一覧
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users

### レスポンス
- 全てのユーザー情報
- HTTPステータス200

## ユーザー詳細
### リクエスト
- HTTP:GET
- Body:
- URL:http://users/:id

### レスポンス
- 特定のユーザー情報
- HTTPステータス200

## 所有チケットの一覧
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users/:id/tickets

### レスポンス
- 特定のユーザーが所有している全てのチケット情報
- HTTPステータス200

## 所有チケットの詳細
### リクエスト
- HTTP:GET 
- Body:
- URL:http://users/:id/tickets/:id

### レスポンス
- 特定のユーザーが所有している特定のチケット情報
- HTTPステータス200

## 所有チケットの譲渡
### リクエスト
- HTTP:POST
- Body:recever_id
- http://user/:id/tickets/:id/transtions
  
### レスポンス
- 譲渡履歴
- HTTPステータス201

## 譲渡履歴の照会機能
### リクエスト
- HTTP:GET
- Body:なし 
- http://user/:id/tickets/:id/transtions
### レスポンス
- 特定のチケットの全ての譲渡履歴
- HTTPステータス200

## 譲渡履歴の照会機能
### リクエスト
- HTTP:GET
- Body:なし 
- http://user/:id/tickets/:id/transtions/:id
### レスポンス
- 特定のチケットの特定の譲渡履歴
- HTTPステータス200

# 今後のアクション
## リファクタリング
- [X]譲渡ロジック(withdraw&deposit)をモデルに移す(update_attributeはバリデーション検証がないため、なるべく使わないようにする)
- [X]transfer_jsonロジックをメタプロで共通化できないか考える
- [X]複数クエリのリクエストを直す
- [X]transitionsコントローラのticket_existでunpermit user_id,ticket_idを直す
- [X]transitionsのcreateのN+1問題を解決する(createアクション)
- [X]transitionのrequestテストケース(create)を描き直す
- [X]permitにキーを入れる
- [X]READMEを描き直す

## +α
- []チケット購入機能
- [X]ticketsテーブルのstatus_idは他の人が見てわかるようにする(テーブル設計状態遷移)
- []バッチ処理の時間差実行、テーブルのアソシエーション、integerからstringに変更

# 実装した案、実装しなかった案

## 実装した案
- イベント系のチケットを想定しており、イベント当日にチケットのステータスが使用可となる
- ticketの一覧は、有効なチケットの中で、event_dateが本日の日付に近いものを優先的に並べる
  
## 実装しなかった案
- []http://user/:id/tickets/:id/transtionsのidは配列で渡せるようにし、複数のチケットを一斉送信できるようにする
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
- 設計:5h
- コーディング:20h
- リファクタリング:8h

# 使用方法
- rails db:create
- rails db:seed
- bundle exec whenever --update-crontab 
- bundle exec whenever --clear-crontab


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