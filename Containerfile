ARG SOURCE_IMAGE="bluefin"
ARG SOURCE_SUFFIX="-dx"
ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY build.sh /tmp/build.sh

#COPY system_files/usr /usr

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

# cleanup
RUN rm -rf /var/cache/* && \
    rm -rf /var/tmp/* && \
    rm -f /tmp/build.sh && \
    rm -f /etc/yum.repos.d/_copr* /etc/yum.repos.d/tailscale.repo && \
    /usr/libexec/containerbuild/cleanup.sh && \
    rm -f /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit
