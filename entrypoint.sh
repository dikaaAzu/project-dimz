#!/bin/bash

# Ganti UUID_PLACEHOLDER dengan UUID dari Environment Variable Railway (jika ada)
if [ -n "$UUID" ]; then
  sed -i "s/UUID_PLACEHOLDER/$UUID/g" /etc/v2ray/config.json
fi

# Mengganti port default (10000) dengan port dari environment Railway ($PORT)
if [ -n "$PORT" ]; then
  sed -i "s/\"port\": 10000/\"port\": $PORT/g" /etc/v2ray/config.json
fi

# Menjalankan V2Ray
exec v2ray -config /etc/v2ray/config.json
