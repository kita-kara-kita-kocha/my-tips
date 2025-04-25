# 再生安定化プロジェクト

目次
1. [streamlinkからvlcで再生してバッファを持たせる](###streamlinkからvlcで再生してバッファを持たせる)
   - [実行コマンド](###実行コマンド)
   - [必要ツール](###必要ツール)
   - [インストール手順](###インストール手順)
   - [※必要設定](###※必要設定)
     
## streamlinkからvlcで再生してバッファを持たせる

 - バッファができてるかは未確認

### 実行コマンド

Power Shellで実行
``` ps
$video_url=xxx
streamlink -p vlc ${video_url} medium
```

### 必要ツール
 - VLC media player: [インストール手順](###VLC media player)
 - streamlink: [インストール手順](###streamlink)

### インストール手順

#### VLC media player

VLC media playerのインストーラをダウンロードして実行

[ダウンロードページ](https://www.videolan.org/vlc/index.ja.html)

難しい項目はないので、詳しくは自分で調べて！

#### streamlink

Power Shellで実行
``` ps
# pipがインストールされているか確認
pip --version
# pipのインストール(上記でインストールが確認できた場合は不要)
python -m pip install --upgrade pip
# streamlinkのインストール
pip install streamlink
# streamlinkのバージョン確認
streamlink --version
```

 - pythonがインストールされていない場合は、[pythonのインストール](https://www.python.org/downloads/)を行う
 - ptyhonからインストールしたくない場合は、公式からインストーラをダウンロード可能
 - pipでのインストールならバージョン管理が楽

### ※必要設定

コマンド実行に必要な設定

#### VLC media playerをPATHに設定する必要があるかも

- ##### インストール先フォルダパスの確認

VLC media playerのショートカットからプロパティを開く -> 「作業フォルダー(S):」の内容を確認(コピー)しておく

- ##### 環境変数Pathに追加

システムのプロパティ -> 詳細設定 -> 環境変数(N)... -> 「ユーザー環境変数(U)」の中にある「Path」を選択し、「編集(E)...」ボタンをクリック -> 確認(コピー)したインストール先パスが含まれていなければ、「新規(N)」ボタンから追加

