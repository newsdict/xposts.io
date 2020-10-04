# define alpine version, you can use --build-arg
ARG alpine_version="3.7"
FROM alpine:${alpine_version}

# go version
ARG go_version="1.15.2"

# Install go
RUN wget https://golang.org/dl/go${go_version}.linux-amd64.tar.gz
RUN tar zxf go${go_version}.linux-amd64.tar.gz -C /usr/local/
RUN ln -s /usr/local/go/bin/go /usr/local/bin/

# Fix to error go. `not found /lib64/ld-linux-x86-64.so.2`
RUN apk add --no-cache libc6-compat

# Set correct environment variables.
RUN mkdir -p /var/www/docker
WORKDIR /var/www/docker

# Set up application
COPY . .

# build
RUN go build

CMD ["go", "run", "main.go"]

EXPOSE 8080