FROM python:alpine3.21

WORKDIR /app

RUN apk update -f \
    && apk add --no-cache -f \
    bash \
    curl \
    # coreutils used by numfmt
    coreutils \
    # gcc and libc-dev used by streamlink
    gcc \
    libc-dev \
    libxml2-dev \
    libxslt-dev \
    openssl \
    perl \
    aria2 \
    exiv2 \
    ffmpeg \
    jq \
    && rm -rf /var/cache/apk/*

RUN pip install --no-cache-dir --upgrade streamlink yq yt-dlp

COPY /volume3/dockerdata/live-dl/live-dl ./
COPY /volume3/dockerdata/live-dl/config.example.yml ./config.yml
RUN chmod a+x ./live-dl

ENTRYPOINT ["./live-dl"]