FROM alpine:latest

# Install dependencies yang dibutuhkan
RUN apk add --no-cache curl unzip

# Download Xray-core terbaru secara langsung
RUN mkdir -p /usr/bin/xray && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /tmp/xray && \
    mv /tmp/xray/xray /usr/bin/xray/xray && \
    mv /tmp/xray/geosite.dat /usr/bin/xray/geosite.dat && \
    mv /tmp/xray/geoip.dat /usr/bin/xray/geoip.dat && \
    chmod +x /usr/bin/xray/xray && \
    rm -rf /tmp/xray.zip /tmp/xray

# Salin file konfigurasi utama
COPY config.json /etc/xray/config.json

# Jalankan Xray langsung membaca port dari Railway ($PORT) lewat sh -c
CMD sh -c "/usr/bin/xray/xray run -c /etc/xray/config.json"
