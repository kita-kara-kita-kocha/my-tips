# ps1
# yt-dlpで、指定したチャンネルの配信予定から、$todays_dateと一致する配信URLを取得する
$channel_id = "xxx" # チャンネルIDを指定
# 例: https://www.youtube.com/channel/UCxxxxxx の場合、UCxxxxxxがチャンネルID
# 例: https://www.youtube.com/@xxxxxx の場合、@xxxxxxがチャンネルID
$todays_date = Get-Date -Format "yyyyMMdd"
$tommorow_date = Get-Date -Format "yyyyMMdd" -Date (Get-Date).AddDays(1)



function Get-ScheduleUrls {
# $todays_live_urlsに引数の日付の配信URLを格納する関数 引数は日付
    $terget_date = $args[0]
    $live_urls = $(yt-dlp --flat-playlist -j "https://www.youtube.com/$channel_id/streams")
    $result_live_urls = @()
    $result_live_urls = $($live_urls | ForEach-Object {
        $live_url = $_ | ConvertFrom-Json
        $live_url | Where-Object { $_.release_date -eq $terget_date } | ForEach-Object {
            $url = $_.url
            Write-Output $url
        }
    })
    return $result_live_urls
}

function Get-LiveUrl {
# 配信中のURLを格納する関数
    $live_urls = $(yt-dlp --flat-playlist -j "https://www.youtube.com/$channel_id/streams")
    $result_live_urls = @()
    $result_live_urls = $($live_urls | ForEach-Object {
        $live_url = $_ | ConvertFrom-Json
        $live_url | Where-Object { $_.is_live -eq "true" } | ForEach-Object {
            $url = $_.url
            Write-Output $url
        }
    })
    return $result_live_urls
}

function Get-LiveContent {
# ダウンロードする関数 引数はターゲットのURLリスト
    $terget_live_urls = $args[0]
    if ($terget_live_urls) {
        Write-Output "ダウンロード中..."
        $terget_live_urls | ForEach-Object {
            Write-Output "ダウンロード中: $_"
            yt-dlp --live-from-start --wait-for-video 5 --retries 10 -o "[%(release_date)s]%(title)s.%(ext)s" $_ -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a] -S vcodec:hevc_nvenc --write-subs --download-archive acv
        }
        Write-Output "ダウンロード完了"
        # ダウンロード完了後、繰り返し$todays_live_urlsを再取得し、立て直しがあれば追加でダウンロード開始する。maxminits分まで繰り返す。
        $end_time = (Get-Date).AddMinutes(30)
        # 立て直しを確認
        while ((Get-Date) -lt $end_time) {
            Write-Output "立て直し確認中..."
            $terget_live_urls = Get-LiveUrl
            if ($terget_live_urls) {
                Write-Output "立て直しを確認しました。"
                Get-LiveContent $terget_live_urls
                break
            Start-Sleep -Seconds 60 # 1分待機
            }
        } else {
            Write-Output "立て直しチェックが完了しました。"
        }
    }
    else {
        Write-Output "配信はありません。"
    }
}

$terget_live_urls_today = Get-ScheduleUrls $todays_date
$terget_live_urls_tommorow = Get-ScheduleUrls $tommorow_date

# $todays_dateの配信をダウンロード
Write-Output "今日配信予定のURLを取得中..."
Get-LiveContent $terget_live_urls_today
# $tommorow_dateの配信をダウンロード
Write-Output "明日の配信予定のURLを取得中..."
Get-LiveContent $terget_live_urls_tommorow
