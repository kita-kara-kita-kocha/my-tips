import subprocess

def stream_video_with_vlc(video_url):
    """
    ストリーミングダウンロードしながらVLCで再生する
    """
    yt_dlp_command = [
        "yt-dlp",
        "--live-from-start",
        "--wait-for-video", "5",
        "--retries", "10",
        video_url,
        "-f", "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]",
        "--merge-output-format", "mp4",
        "--hls-prefer-native",
        "--hls-use-mpegts",
        "--hls-split-discontinuities",
        "--hls-split-frames", "1",
        "--hls-timeout", "10",
        "-o", "-"
    ]

    vlc_command = ["vlc", "-"]

    try:
        # yt-dlpの出力をVLCにパイプで渡す
        with subprocess.Popen(yt_dlp_command, stdout=subprocess.PIPE) as yt_dlp_proc:
            subprocess.run(vlc_command, stdin=yt_dlp_proc.stdout)
    except FileNotFoundError as e:
        print(f"エラー: 必要なコマンドが見つかりません: {e}")
    except Exception as e:
        print(f"エラーが発生しました: {e}")

if __name__ == "__main__":
    # 動画URLを指定
    video_url = "https://example.com/live/stream/url"
    stream_video_with_vlc(video_url)