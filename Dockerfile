FROM alpine as downloader
LABEL maintainer="kraus1049 <kraus1049@gmail.com>"

ARG SRCDIR=https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-v0.12.1-x86_64-unknown-linux-musl.tar.gz
RUN apk update && apk add \
    curl && \
    curl -LO ${SRCDIR} && \
    tar xzvf *tar.gz && \
    mkdir /work

#FROM scratch as runner
FROM alpine as runner
ARG SOFTWARE_NAME=bat
COPY --from=downloader /bat-v0.12.1-x86_64-unknown-linux-musl/bat /bat
COPY --from=downloader /work /work
ENV PATH=/:PATH
WORKDIR /work

CMD ["/bat"]