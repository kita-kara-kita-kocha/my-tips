# 2つのIPにpingをループ実行し、タイムアウトがあれば記録する
# 設定する値
# 8行目: $target_global: グローバルIP、8.8.8.8はGoogleのDNSサーバー、1.1.1.1はCloudflareのDNSサーバーどちらでも可(分からなければそのままでOK)
# 9行目: $target_local: ローカルIP、以下のコマンドで確認してください
# ipconfig 
# 利用しているネットワークアダプターのデフォルトゲートウェイのIPアドレス(ipv4)を指定してください

$target_global = "8.8.8.8"
$target_local = "192.168.0.1"

# ファイルping_log.txtを作成
function Create-LogFile {
    if ($args.Count -gt 0) {
        $logFilePath = "ping_log.txt"
    } else {
        $logFilePath = $args[0]
    }
    if (-Not (Test-Path $logFilePath)) {
        New-Item -Path $logFilePath -ItemType File -Force
        Write-Output "Log file created at $logFilePath."
    } else {
        Write-Output "Log file already exists at $logFilePath."
    }
}

function Test-Ping {
    param (
        [string]$target,
        [int]$timeout = 1000
    )

    $pingResult = Test-Connection -ComputerName $target -Count 1 -ErrorAction SilentlyContinue
    if ($pingResult) {
        Write-Output "Ping to $target successful."
        Write-Output $pingResult
    } else {
        Write-Output "Ping to $target failed."
        # タイムアウトがあれば、タイムスタンプを記録する
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path "ping_log.txt" -Value "$($timestamp): Ping to $target failed."
    }
}

Create-LogFile "ping_log.txt" # ping_log.txtを作成
# ping_log.txtを作成

# 1分毎のループ　1時間後まで実行
$endTime = (Get-Date).AddHours(1)
while ((Get-Date) -lt $endTime) {
    Test-Ping -target $target_global
    Test-Ping -target $target_local
    Start-Sleep -Seconds 1
}