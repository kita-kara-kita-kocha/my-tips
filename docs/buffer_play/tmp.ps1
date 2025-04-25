$video_url = "xxxxx"
# ストリーミングダウンロードしながらvlcで再生する
yt-dlp --live-from-start --wait-for-video 5 --retries 10 $video_url -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 --hls-prefer-native --hls-use-mpegts --hls-split-discontinuities --hls-split-frames 1 --hls-timeout 10 -o - | vlc -