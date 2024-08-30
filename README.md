# Flightradar24 feeder Docker image

Flightradar24 へADS-Bデータを送信する為のDocker image.

## Usage

Docker compose での利用方法.

- `.env` に環境変数を定義.( `compose.yaml` に直接記載する方法でも可 )

```dotenv
# ADS-Bのデータを取得するホスト名.(初期値: readsb) 
BEASTHOST="readsb"
# ADS-Bのデータを取得するポート番号.(初期値: 30005)
BEASTPORT="30005"
# Flightradar24のフィーダーキー.
FR24FEED_FR24KEY="xxxxxxxxxxxxxxxx"
# MLATを有効化するか.(初期値: no)
FR24FEED_MLAT="yes"
# NTPサーバー.(任意のNTPサーバーを設定)
FR24FEED_NTP_SERVER="example.com"
```

- `compose.yaml` の例.

```yaml
services:
  fr24feed:
    image: otofu/fr24feed:latest
    restart: unless-stopped
    environment:
      BEASTHOST: "${BEASTHOST}"
      BEASTPORT: "${BEASTPORT}"
      FR24KEY: "${FR24FEED_FR24KEY}"
      MLAT: "${FR24FEED_MLAT}"
      NTP_SERVER: "${FR24FEED_NTP_SERVER}"
```
