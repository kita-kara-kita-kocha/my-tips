# 自動ダウンロードプロジェクト

- 動画を保存したいフォルダに、`schedule.ps1`をコピー
- 3行目の`$channel_id = "xxx"`に保存したい対象のチャンネルIDを入力保存
- タスクスケジューラーで`schedule.ps1`が毎日実行されるように設定

 ## 動作説明

1. `schedule.ps1`を実行すると、指定したチャンネルの当日の配信予定を取得し、ダウンロードします。(配信開始時間まで待機します。あとから配信時間が早まったら失敗するかも)
1. ダウンロード完了後、再度配信情報を取得し、枠の撮り直しがないか確認します。
1. もし枠の撮り直しがあった場合、再度ダウンロードを行います。
1. もし枠の撮り直しがなかった場合、次の日の配信予定を取得し、ダウンロードします。
1. ダウンロード完了後、再度配信情報を取得し、枠の撮り直しがないか確認します。
1. もし枠の撮り直しがあった場合、再度ダウンロードを行います。
1. 終了