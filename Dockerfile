FROM alpine:latest

RUN apk add \
  --no-cache \
  --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
  gleam=~1.5

RUN apk add rebar3 build-base bsd-compat-headers curl nodejs

COPY . /app

WORKDIR /app

CMD ["sh", "./entrypoint.sh"]
