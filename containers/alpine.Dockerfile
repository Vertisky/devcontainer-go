ARG BASE_VERSION=v0.3.0
ARG GO_VERSION=latest

FROM ghcr.io/vertisky/devcontainers-base:alpine-${BASE_VERSION}
ARG VERSION
ARG COMMIT
ARG BUILD_DATE
ARG BASE_VERSION
ARG GO_VERSION

LABEL \
    org.opencontainers.image.title="GoDevContainer" \
    org.opencontainers.image.description="Alpine Golang image for dev containers." \
    org.opencontainers.image.url="https://github.com/vertisky/devcontainers" \
    org.opencontainers.image.documentation="https://github.com/vertisky/devcontainers" \
    org.opencontainers.image.source="https://github.com/vertisky/devcontainers" \
    org.opencontainers.image.vendor="vertisky" \
    org.opencontainers.image.authors="etma@vertisky.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.created=$BUILD_DATE

RUN PATH=$PATH:/root/.asdf/bin && \
    /root/.asdf/bin/asdf plugin add golang && \
    /root/.asdf/bin/asdf install golang $GO_VERSION && \
    /root/.asdf/bin/asdf global golang $GO_VERSION

# install golangci-lint
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.50.1
