FROM alpine:latest

# Install curl dan unzip
RUN apk add --no-cache curl unzip

# Download Xray-core terbaru
RUN mkdir -p /usr/bin/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /tmp/xray && \
    mv /tmp/xray/xray /usr/bin/xray/xray && \
    mv /tmp/xray/geosite.dat /usr/bin/xray/geosite.dat && \
    mv /tmp/xray/geoip.dat /usr/bin/xray/geoip.dat && \
    chmod +x /usr/bin/xray/xray && \
    rm -rf /tmp/xray.zip /tmp/xray

# Salin file konfigurasi
COPY config.json /etc/xray/config.json

# Jalankan Xray dengan membaca port dinamis Railway secara otomatis
CMD sh -c "sed -i \"s/\\\"port\\\": 10000/\\\"port\\\": \$PORT/g\" /etc/xray/config.json && /usr/bin/xray/xray run -c /etc/xray/config.json"
