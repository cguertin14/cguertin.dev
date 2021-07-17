# Stage 1 - builder
FROM golang:1.16.6-alpine AS build

LABEL maintainer="Charles Guertin"

RUN apk add --update --no-cache git && \
    apk upgrade

ENV HUGO_VERSION=v0.83.1
RUN go get -u github.com/gohugoio/hugo@${HUGO_VERSION}

COPY src/ /src
WORKDIR /src
RUN hugo


# Step 2 - runtime
FROM nginx:1.20.0-alpine AS runtime
COPY --from=build /src/public/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]