#!/bin/sh
set -e

MITMPROXY_PATH="/home/mitmproxy/.mitmproxy"

mkdir -p "$MITMPROXY_PATH"
chown -R mitmproxy:mitmproxy "$MITMPROXY_PATH"

su-exec mitmproxy mitmproxy \
    -m transparent \
    -s adblock.py \
    --set stream_large_bodies=500k \
    --set ssl_insecure=true