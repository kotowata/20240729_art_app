# ArtSpotly
https://artspotly.com

## ■サービス概要
訪れた美術館（展覧会）のポスター写真を投稿・閲覧ができるアプリです。<br>
イベントポスターをアートとして閲覧し楽しむことができます。<br>
投稿の中から気になるイベントを見つけることができ、美術館に遊びに行きやすくなります。<br>
<br>

## ■ このサービスへの思い・作りたい理由
美術館のイベントポスターは、イベントの魅力や面白さを象徴する一枚になっているため、<br>
ポスター写真を並べて閲覧できたら楽しめるのではないかと考えました。<br>
展示品は基本的に撮影NGのことが多く、会場入口の大型ポスターの写真だけ記念に撮影する人も多いです。<br>
せっかく撮った写真を皆で共有できたら思い出を残せておすすめもでき、美術館巡りをより楽しめるかと思います。<br>
また、美術館に馴染みがない人にも、気軽に絵を楽しむ面白さを知るきっかけを提供できるのではと考えました。<br>
<br>

## ■ ユーザー層について
・美術館に行く人<br>
・美術館やアートに興味がある人<br>
<br>

## ■サービスの利用イメージ
・美術館のポスター写真や鑑賞した感想を投稿できる。<br>
・各投稿からイベント詳細（イベントURL・期間・場所）を確認できる。<br>
・他の人の投稿や自分の投稿一覧を見ることができる。<br>
・美術館ユーザーは思い出を記録として残すことができ、美術館に詳しくない人は会期中の面白そうな展示を見つけやすくなる。<br>
<br>

## ■ ユーザーの獲得について
・美術館に行く人<br>
　→美術館巡りの記録を残せる、よかった展示の感想をシェアしおすすめができる<br>
・美術館やアートに興味がある人<br>
　→美術館の展示情報を見つけやすくなる<br>
<br>

## ■ サービスの差別化ポイント・推しポイント
単なる投稿アプリではなく、ユーザーとアプリ上で擬似美術館を作るイメージです。<br>
投稿写真＝アート<br>
アプリ＝展示会場<br>
のようにして視覚的に楽しめるアプリを目指します。<br>
<br>

## ■ 機能
|トップ|ログイン|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/86671e46953999790e55ff4caaaae916.png)](https://gyazo.com/86671e46953999790e55ff4caaaae916)|[![Image from Gyazo](https://i.gyazo.com/badc2eea32e5dab69b62df31cfe906af.png)](https://gyazo.com/badc2eea32e5dab69b62df31cfe906af)|
|使い方と「使ってみるボタン」を設置し<br>使いやすい動線設計|Googleアカウントでのログインが可能|

|ポスト一覧|ポスト詳細|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/b9672f021ba53d3864af69bc4bf4e881.jpg)](https://gyazo.com/b9672f021ba53d3864af69bc4bf4e881)|[![Image from Gyazo](https://i.gyazo.com/9992058aeb729ec4e0a9d20da1a0717d.jpg)](https://gyazo.com/9992058aeb729ec4e0a9d20da1a0717d)|
|ログイン不要で閲覧できる一覧画面<br>美術館風のデザイン|展示の詳細を見ることができる|

|新規投稿|周辺美術展検索|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/875671e44a02b5e86039e63b73e353e5.png)](https://gyazo.com/875671e44a02b5e86039e63b73e353e5)|[![Image from Gyazo](https://i.gyazo.com/e2e6263ff826ecf8b497b974a9f05431.jpg)](https://gyazo.com/e2e6263ff826ecf8b497b974a9f05431)|
|選択フォームなど入力しやすい設計|現在地付近の美術展を調べられる<br>任意の地名での検索も可能|
<br>

## ■ 技術スタック
| カテゴリ | 技術 |
----|----
| フロントエンド | HTML, Javascript, CSS, TailwindCSS, daisyUI |
| バックエンド | Ruby 3.2.3, Rails 7.2.1 |
| データベース | PostgreSQL |
| 開発環境 | Docker |
| インフラ | Render.com, Amazon S3 |
| CI/CL | GitHubActions |
| Web API | Google Maps API( Maps Javascript API / Places API / Geocoding API / Geolocation API )
<br>

### 画面遷移図
Figma：https://www.figma.com/design/m8NSla9F8igoj9aAnLWSbJ/%E5%8D%92%E6%A5%AD%E5%88%B6%E4%BD%9C%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3_rev1?node-id=0-1&t=ig0lTzq7U6TB9yCh-1
<br>

### ER図
[![Image from Gyazo](https://i.gyazo.com/3a4fa2c193c9c7b0b3c6784f14c93787.png)](https://gyazo.com/3a4fa2c193c9c7b0b3c6784f14c93787)
<br>