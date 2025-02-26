ARG BASE_VERSION=v2.0.3
ARG GO_VERSION=alpine

FROM golang:${GO_VERSION} AS go

FROM etma/devcontainer-base:alpine-${BASE_VERSION}
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


    COPY --from=go /usr/local/go /usr/local/go

    # Set GOROOT and update PATH
    ENV GOROOT=/usr/local/go
    ENV PATH="${GOROOT}/bin:${PATH}"
    
    
    # install golangci-lint
    RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.64.5
    
    # install gopls
    RUN go install golang.org/x/tools/gopls@latest
    
    # cleanup
    RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*
    RUN go clean -cache -modcache -testcache -fuzzcache && rm -rf $(go env GOCACHE) $(go env GOMODCACHE)
