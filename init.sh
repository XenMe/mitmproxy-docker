#!/bin/sh
set -e

MITMPROXY_PATH="/home/mitmproxy/.mitmproxy"

mkdir -p "$MITMPROXY_PATH"
chown -R mitmproxy:mitmproxy "$MITMPROXY_PATH"

su-exec mitmproxy mitmproxy