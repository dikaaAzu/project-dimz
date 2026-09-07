#!/bin/sh

# Mengganti placeholder UUID dengan UUID dari Environment Variable Railway
if [ -n "$UUID" ]; then
  sed -i "s/85e0c57f-b259-48a7-b21d-cc5b1e70594f/$UUID/g" /etc/v2ray/config.json
fi

# Mengganti port 10000 dengan port dinamis dari Railway ($PORT)
if [ -n "$PORT" ]; then
  sed -i "s/\"port\": 443/\"port\": $PORT/g" /etc/v2ray/config.json
fi

# Menjalankan V2Ray dengan format perintah yang benar (tanpa tanda strip di depan config)
exec /usr/bin/v2ray/v2ray run -config /etc/v2ray/config.json
