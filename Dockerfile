FROM alpine:latest

# Install curl dan unzip
RUN apk add --no-cache curl unzip

# Download langsung file biner v2ray versi terbaru
RUN mkdir -p /usr/bin/v2ray && \
    curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip /tmp/v2ray.zip -d /tmp/v2ray && \
    mv /tmp/v2ray/v2ray /usr/bin/v2ray/v2ray && \
    mv /tmp/v2ray/geosite.dat /usr/bin/v2ray/geosite.dat && \
    mv /tmp/v2ray/geoip.dat /usr/bin/v2ray/geoip.dat && \
    chmod +x /usr/bin/v2ray/v2ray && \
    rm -rf /tmp/v2ray.zip /tmp/v2ray

# Salin file konfigurasi dan entrypoint
COPY config.json /etc/v2ray/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
