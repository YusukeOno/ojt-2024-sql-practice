# ojt-2024-sql-practice

これは、Web上でSQL文を動作するサイト「DB Fiddle」を使って、SQLの理解度をチェックするための教材です。  

各問ごとにテーブル定義情報やサンプルデータを`Schema.sql`に記載していますので、各問の解答となるSQLを作成してみましょう。

## 設問

1. [問１　東京の人口](./question-1/README.md)
2. [問２　平均睡眠時間](./question-2/README.md)
3. [問３　入出国者](./question-3/README.md)
4. [問４　外国籍の多い都道府県](./question-4/README.md)

## DB Fiddleの使い方

* [DB Fiddle](https://www.db-fiddle.com/)にアクセスします。
  * アカウント作成やログインは不要です。
* ヘッダー部にある`Database`より、`MySQL 8.0`を選択します。
* 左側ペインの`Schema SQL`に、各フォルダにある`Schema.sql`のファイル内容をコピーアンドペーストします。
* 右側ペインの`Query SQL`に、答えとなるSQL文を記載します。
* 記載したSQLを実行するには、ヘッダー部にある`Run`で実行します。
* 記載したSQL文は、`Answer.sql`に転記します。

### 参考URL

* ※出典：政府統計の総合窓口[(e-Stat)(https://www.e-stat.go.jp/)](https://www.e-stat.go.jp/)「令和２年国勢調査 人口等基本集計」を加工して作成
* [簡単にSQLを試せるツール「DB Fiddle」がスゴイ
@Zenn](https://zenn.dev/sql_geinin/articles/7454c2350259b9)

以上