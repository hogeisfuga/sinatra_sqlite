#!/bin/bash
set -eo pipefail

# スクリプトが存在するディレクトリのパス
script_dir=$(dirname "$0")

# SQLファイルが格納されているディレクトリのパス
sql_file_path="$script_dir/scripts"

# スクリプトディレクトリ内のSQLファイル名を取得
script_names=$(ls "$sql_file_path")

# データベースファイルのパス
db_file="$script_dir/sample_db.sqlite3"

# データベースファイルが存在する場合は削除
if [ -f "$db_file" ]; then
  rm "$db_file"
fi

# データベースファイルを新規作成
touch "$db_file"

# 各SQLファイルを実行
for file in $script_names; do
  # SQLファイルの絶対パスを生成
  sql_file="$sql_file_path/$file"
  
  # sqlite3でSQLファイルを実行
  sqlite3 "$db_file" < "$sql_file"
done
