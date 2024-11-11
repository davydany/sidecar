FROM alpine:latest

# Set environment variables to avoid cache issues
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Additional packages that make it easier to work in the terminal
# bat - for syntax highlighting in the terminal
# fzf - for fuzzy search in general terminal use, enhances navigation in any TUI
# ncdu - for disk usage analysis
RUN apk update && \
    apk add --no-cache bash zsh curl vim nano postgresql-client redis kafkacat jq curl python3 py3-pip openjdk11-jre openjdk11-jre kubectl go aws-cli fzf ncdu bat openssl openssh bind git && \
    rm -rf /var/cache/apk/*

# things not installed: nats clickhouse-client

# Install terminal UIs

# Setup a new virtualenv for python packages
# and then install packages that we want to install
# in this virtualenv
RUN python3 -m venv /root/venv && \
    source /root/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --upgrade pgcli httpie

# Install kaf - A rich CLI for Kafka
# installed from source to get the latest version
RUN go install github.com/birdayz/kaf/cmd/kaf@latest

# redli - TUI for Redis, requires additional libc compatibility for Alpine
RUN apk add --no-cache libbsd && \
    curl -Lo /usr/local/bin/redli https://github.com/IBM-Cloud/redli/releases/download/v0.5.0/redli-linux-amd64 && \
    chmod +x /usr/local/bin/redli

# Setup VIM
COPY vim/vimrc /root/.vimrc

# Cleanup to reduce image size
RUN rm -rf /var/cache/apk/*

# Install kubectl-plugins
RUN git clone https://github.com/luksa/kubectl-plugins /root/kubectl-plugins

# Setup ENV variables
ENV PATH="/root/venv/bin:/root/go/bin:/root/kubectl-plugins:${PATH}"

WORKDIR /root

# Set default shell
SHELL ["/bin/zsh", "-c"]
