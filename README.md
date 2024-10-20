# ArtSpotly

### ■サービスURL
https://artspotly.com<br>
<br>

### ■サービス概要
訪れた美術館（展覧会）のポスター写真を投稿・閲覧ができるアプリです。<br>
イベントポスターをアートとして閲覧し楽しむことができます。<br>
投稿の中から気になるイベントを見つけることができ、美術館に遊びに行きやすくなります。<br>
<br>

### ■ このサービスへの思い・作りたい理由
美術館のイベントポスターは、イベントの魅力や面白さを象徴する一枚になっているため、<br>
ポスター写真を並べて閲覧できたら楽しめるのではないかと考えました。<br>
展示品は基本的に撮影NGのことが多く、会場入口の大型ポスターの写真だけ記念に撮影する人も多いです。<br>
せっかく撮った写真を皆で共有できたら思い出を残せておすすめもでき、美術館巡りをより楽しめるかと思います。<br>
また、美術館に馴染みがない人にも、気軽に絵を楽しむ面白さを知るきっかけを提供できるのではと考えました。<br>
<br>

### ■ ユーザー層について
・美術館に行く人<br>
・美術館やアートに興味がある人<br>
<br>

### ■サービスの利用イメージ
・美術館のポスター写真や鑑賞した感想を投稿できる。<br>
・各投稿からイベント詳細（イベントURL・期間・場所）を確認できる。<br>
・他の人の投稿や自分の投稿一覧を見ることができる。<br>
・美術館ユーザーは思い出を記録として残すことができ、美術館に詳しくない人は会期中の面白そうな展示を見つけやすくなる。<br>

### ■ ユーザーの獲得について
・美術館に行く人<br>
　→美術館巡りの記録を残せる、よかった展示の感想をシェアしおすすめができる<br>
・美術館やアートに興味がある人<br>
　→美術館の展示情報を見つけやすくなる<br>
<br>

### ■ サービスの差別化ポイント・推しポイント
単なる投稿アプリではなく、ユーザーとアプリ上で擬似美術館を作るイメージです。<br>
投稿写真＝アート<br>
アプリ＝展示会場<br>
のようにして視覚的に楽しめるアプリを目指します。<br>
<br>

### ■ 機能候補
mvpリリースまで<br>
・ユーザー登録<br>
・投稿機能（写真 展示会URLなどの情報）<br>
・お気に入り、リスト機能<br>
・検索機能<br>
・会期中イベントのみピックアップ<br>
<br>
本リリースまで<br>
・イベントの位置情報<br>
・おすすめ機能<br>
・画像加工機能<br>
・リスト機能<br>
<br>

### ■ 機能の実装方針予定
| カテゴリ | 技術 |
----|----
| フロントエンド | HTML, Javascript, CSS, Tailwind CSS, daisyUI |
| バックエンド | Ruby 3.2.3, Rails 7.2.1 |
| データベース | PostgreSQL |
| 開発環境 | Docker |
| インフラ | Render.com, Amazon S3 |
| CI/CL | GitHubActions |
| Web API | Google Maps API( Maps Javascript API / Places API / Geocoding API / Geolocation API )
<br>

**現時点で想定してるgemやライブラリ：**<br>
sorcery<br>
rails-i18n<br>
draper<br>
carrierwave<br>
turbo-rails<br>
kaminari<br>
kaminari-i18n<br>
ransack<br>
launchy<br>
config<br>
pundit<br>
gretel<br>
enum_help<br>
whenever<br>
letter_opener_web<br>
<br>
Vibrant.js<br>
ColorThief<br>
<br>

### 画面遷移図
Figma：https://www.figma.com/design/m8NSla9F8igoj9aAnLWSbJ/%E5%8D%92%E6%A5%AD%E5%88%B6%E4%BD%9C%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3_rev1?node-id=0-1&t=ig0lTzq7U6TB9yCh-1
<br>

### ER図
[![Image from Gyazo](https://i.gyazo.com/3a4fa2c193c9c7b0b3c6784f14c93787.png)](https://gyazo.com/3a4fa2c193c9c7b0b3c6784f14c93787)
<br>