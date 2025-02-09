# All Ready

サービスURL：[All Ready](https://allready.jp)

<img src="https://www.allready.jp/assets/ogp-b4d87c539fa6e51863d052081489dc7407781bee9999e42efe21ecb3068db31a.png" width="900px" />

## サービス概要

持ち物リストを作成し、かばんの中身を投稿・共有できるサービスです。<br>
自分の持ち物を整理し、他のユーザーのかばんの中身を参考にすることで、持ち物リストをブラッシュアップできます。<br>
また、マストアイテムのみを投稿することもできます。

## サービスへの想い、作りたい理由

行き先に応じた持ち物リストを作成し、準備を整える時間が好きです。<br>
例えば旅行の際には、直前まで使うものをチェックしておくことで、忘れずに出発できます。<br>
旅先で「持ってくればよかった」と感じたものをリストに追加すると、次回の準備がよりスムーズになります。

また、雑誌やWebサイト等でかばんの中身を紹介する記事を読むのも好きです。<br>
誰が何をどのくらい持ち歩いているのかを知ることで、その人のライフスタイルやこだわりが垣間見え、とても興味深いと感じます。<br>

このサービスを通じて、自分の持ち物を整理するだけでなく、他のユーザーと共有し合い、より良い準備をサポートする場を提供したいと思っています。

## ユーザー層について

- **自分の持ち物を整理したい人**<br>
持ち物を視覚化することで管理しやすくなります。
- **他の人のかばんの中身を参考にしたい人**<br>
他のユーザーの持ち物から新しいアイデアや有用な情報を得られます。

## サービスの利用イメージ

ユーザーは、行き先に応じた持ち物リストを作成し、必要なアイテムを忘れずに準備できます。<br>
また、他のユーザーの持ち物リストやマストアイテムを閲覧し、自分の持ち物を改善するアイデアを得ることができます。

## ユーザーの獲得について

- Xを用いた宣伝
- 知人に宣伝

## サービスの差別化ポイント・推しポイント

類似サービスは複数存在しますが、持ち物リストの作成か、かばんの中身の紹介のどちらかに特化しています。<br>
両方の側面を持つサービスを作ることにより、ユーザーが自分の持ち物を整理しつつ、他のユーザーのアイデアを取り入れることができます。

## 機能候補

### MVPリリース

- ユーザー登録
- ログイン
- ログアウト
- 持ち物リスト（作成、編集、削除、閲覧）
    - 既存のアイテムをリストに追加
    - オリジナルのアイテムをリストに追加
    - アイテム数の設定
    - タグの追加
    - 共有設定
    - 画像アップロード
    - 検索（キーワード、タグ）
- マストアイテム（作成、編集、削除、閲覧）
    - 画像アップロード
- マイページ

### 本リリース

- 持ち物リスト
    - アイテムの並び替え
    - 準備の達成度をゲージで表示
    - 準備済みのアイテムを非表示
    - 準備済みのアイテムをクリア
    - リストの複製
- アバター画像アップロード
- ブックマーク
- Googleログイン
- パスワードリセット
- ライトモード・ダークモードの切り替え
- ローディングアニメーション
- 独自ドメイン
- レスポンシブ対応
- Xへのシェア
- お問い合わせ
- 利用規約
- プライバシーポリシー
- ファビコン
- PWA
- Googleアナリティクス
- RSpec

## 使用技術

| カテゴリ | 技術 |
| --- | --- |
| フロントエンド | TailwindCSS / daisyUI / JavaScript
| バックエンド | Ruby 3.2.3 / Rails 7.2.1 |
| データベース | PostgreSQL |
| 開発環境 | Docker |
| インフラ | Heroku / AmazonS3 |
| API | OmniAuth Google OAuth2 |
| VCS | GitHub |
| CI/CD | GitHub Actions |

## 画面遷移図
https://www.figma.com/design/8f474smVjo7Xg5O3HH0DZq/All-Ready?node-id=0-1&t=96jaDDCyTNPncGzS-1

## ER図
https://dbdiagram.io/d/All-Ready-670be10097a66db9a3cf1d05
