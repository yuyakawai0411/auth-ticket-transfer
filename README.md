# アプリの前提条件
- ユーザーはすでに複数枚のチケットを所持している
- チケットの譲渡には金銭的やり取りは発生しない
- チケットの受け取り手にはチケット譲渡の拒否権はない
- ユーザー名は一意である
- イベント系のチケットを想定しており、イベント当日に使用可能となる
- 認証機能は必要としない
  
# API仕様

## 所有チケットの照会機能
### リクエスト
- HTTP:GET 
- Body:
- URL:http://user/:id

### レスポンス
- ユーザーが所有している全てのチケット
- HTTPステータス200
  
## 所有チケットの譲渡機能
### リクエスト
- HTTP:POST
- Body:ticket,recever
- http://user/:id/ticket/:id/transtions
### レスポンス
- ユーザーが譲渡したチケット名前、枚数、送り主、送り先
- HTTPステータス201

## 譲渡履歴の照会機能
### リクエスト
- HTTP:GET
- Body:なし 
- http://user/:id/ticket/:id/transtions
### レスポンス
- 全ユーザーの譲渡履歴
- HTTPステータス200

# 実装した案、実装しなかった案
## 実装した案
- チケットからのみ検索できる譲渡履歴


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
- 設計:3h
- コーディング:4h
- リファクタリング:

# 使用方法
- rails db:create
- rails db:seed