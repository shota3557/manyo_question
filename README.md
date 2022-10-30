＜テーブルのカラム名＞

| テーブル名 | カラム名         | データ型  | 
| -------- | --------------- | -------- | 
| Users    | name           | string   | 
|          | email           | string   | 
|          | password_digest | string   | 
| Tasks    | id              |          | 
|          | user_id         |          | 
|          | name            | string   | 
|          | content         | text     | 
| Labelings| task_id         |          | 
|          | label_id        |          | 
| Labels   | id              |          | 

＜Herokuへのデプロイ手順＞
1.Herokuに新しいアプリケーションを作成する
  Heroku上にアップしたいディレクトリに移動し、
ターミナルで「heroku create」コマンドを入力する。
（Heroku上で新しいアプリケーションを作成する）

2.「Heroku buildpack」を追加する
  作成したアプリをHeroku上でコンパイルするために必要で、
ターミナル上で「heroku buildpacks:set heroku/ruby」と入力

3.「node.js」のbuildpackを追加する
  ターミナル上で「 heroku buildpacks:add --index 1 heroku/nodejs」と入力

4.Heroku にデプロイする
  ターミナル上で「git push heroku ブランチ名」と入力する

5.Heroku上のアプリケーションにアクセスする
  ターミナルで「heroku open」と入力する


