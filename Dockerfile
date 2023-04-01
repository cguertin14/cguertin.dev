# Stage 1 - builder
FROM golang:alpine AS build

LABEL maintainer="Charles Guertin"

RUN apk add --update --no-cache git && \
    apk upgrade

ENV HUGO_VERSION=v0.111.3
RUN go install github.com/gohugoio/hugo@${HUGO_VERSION}

COPY src/ /src
WORKDIR /src
RUN hugo


# Step 2 - runtime
FROM nginx:stable-alpine AS runtime
COPY --from=build /src/public/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
