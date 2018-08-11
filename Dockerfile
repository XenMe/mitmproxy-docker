FROM alpine:3.7

ENV LANG=en_US.UTF-8

ARG MITMPROXY_VERSION=4.0.4
ARG WHEEL_MITMPROXY=https://snapshots.mitmproxy.org/${MITMPROXY_VERSION}/mitmproxy-${MITMPROXY_VERSION}-py3-none-any.whl 
ARG WHEEL_BASENAME_MITMPROXY=mitmproxy-${MITMPROXY_VERSION}-py3-none-any.whl

# Add our user first to make sure the ID get assigned consistently,
# regardless of whatever dependencies get added.
RUN addgroup -S mitmproxy && adduser -S -G mitmproxy mitmproxy \
    && apk add --no-cache \
        su-exec \
        curl \
        iptables \
        git \
        g++ \
        libffi \
        libffi-dev \
        libstdc++ \
        openssl \
        openssl-dev \
        python3 \
        python3-dev \
    && python3 -m ensurepip \
    && cd /home/mitmproxy \
    && curl -SLO ${WHEEL_MITMPROXY} \
    && LDFLAGS=-L/lib pip3 install -U /home/mitmproxy/${WHEEL_BASENAME_MITMPROXY} \
    && apk del --purge \
        git \
        g++ \
        libffi-dev \
        openssl-dev \
        python3-dev \
    && rm -rf ~/.cache/pip /home/mitmproxy/${WHEEL_BASENAME_MITMPROXY}

VOLUME /home/mitmproxy/.mitmproxy

COPY init.sh /
ENTRYPOINT ["/init.sh"]

EXPOSE 8080 8081