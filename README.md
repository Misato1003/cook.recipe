# Cook.Recipe


(1) 目的　　

  　このアプリケーションは、料理の検索、登録、レビューを投稿することができます。
   
  　料理を作る際、何を作るのか悩んでいる時に、料理を検索することで、悩みを解決することができます。
   
   
(2) Cook.Recipeの本番環境　　　　　

   オリジナルのポートフォリオになります。
   
   　https://new-cook-recipe.herokuapp.com/
     
     
(3) 実装した機能

* ユーザーの新規登録

* ユーザーのログイン、ログアウト

* ユーザの更新、編集

* パスワードを忘れた際の再設定

* 料理の新規登録、更新、編集、詳細、削除

* レビューの登録、更新、編集、詳細、削除

* 料理のお気に入り登録

* 料理のお気に入り済みの表示

* 料理の検索


(4) 苦労したこと

* リレージョンが難しかった。（特に、お気に入り済みの登録、一覧表示のところが難しかった。）
  
  一対多なのか、多対多なのか、考えながら、作成をすれば良かったです。紙に一回必要なDBの情報を書き出して、どれをどう繋ぐのか（外部キー）を考えながら、作業をすれば良かったです。
  
* rspecの書き方が分からず苦労しました。

  サイトを調べながら、rspecを書きました。request,controller,model,featuresなど、数多くのテストがあり、どれを使用すれば良いのかが分からなかったです。また、rspecの書き方が分からず、戸惑ってしまいました。
  
(5)こだわったこと
  
* 料理、レビューを登録する際、ユーザーがログインしないと、登録できないようにした。
* 料理の編集、更新、レビューの編集、更新は、登録したユーザーのみ編集、更新できるようにした。

(6)失敗したこと（今後、修正した方が良いと思うところ

*  料理の一覧表のところを、テーブル（表）でなくて、画像の下に料理名、料理のポイントなど分かりやすく表示した方が、スマホのレスポンシブ対応にした際、より見やすくなると思った。
  
