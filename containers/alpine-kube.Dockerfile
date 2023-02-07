ARG BASE_VERSION=v1.2.1
ARG GO_VERSION=latest

FROM etma/devcontainer-kube:alpine-${BASE_VERSION}
ARG VERSION
ARG COMMIT
ARG BUILD_DATE
ARG BASE_VERSION
ARG GO_VERSION

LABEL \
    org.opencontainers.image.title="DevContainer for golang" \
    org.opencontainers.image.description="Alpine Golang image for dev containers." \
    org.opencontainers.image.url="https://github.com/vertisky/devcontainers-go" \
    org.opencontainers.image.documentation="https://github.com/vertisky/devcontainers-go" \
    org.opencontainers.image.source="https://github.com/vertisky/devcontainers-go" \
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
RUN PATH=$PATH:/root/.asdf/bin:/root/.asdf/shims && \
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.50.1
