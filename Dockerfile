FROM alpine:latest

# Set environment variables to avoid cache issues
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apk update && \
    apk add --no-cache bash zsh curl vim nano postgresql-client redis kafkacat jq python3 py3-pip openjdk11-jre openjdk11-jre kubectl aws-cli && \
    rm -rf /var/cache/apk/*

# things not installed: nats clickhouse-client

# Install Elasticsearch client
RUN apk add --no-cache openjdk11-jre && \
    curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz && \
    tar -xzf elasticsearch-7.10.2-linux-x86_64.tar.gz && \
    rm elasticsearch-7.10.2-linux-x86_64.tar.gz

# Install terminal UIs

# pgcli - TUI for PostgreSQL
RUN pip install --upgrade pip pgcli

# redli - TUI for Redis, requires additional libc compatibility for Alpine
RUN apk add --no-cache libbsd && \
    curl -Lo /usr/local/bin/redli https://github.com/IBM-Cloud/redli/releases/download/v0.5.0/redli-linux-amd64 && \
    chmod +x /usr/local/bin/redli

#

# # Install kaf - A rich CLI for Kafka
RUN curl -Lo /usr/local/bin/kaf https://github.com/birdayz/kaf/releases/download/v0.2.5/kaf_linux_amd64 && \
    chmod +x /usr/local/bin/kaf

# # fzf - for fuzzy search in general terminal use, enhances navigation in any TUI
RUN apk add --no-cache fzf

# # ncdu - for checking disk usage in the container, useful for database size monitoring
RUN apk add --no-cache ncdu

# # Cleanup to reduce image size
RUN rm -rf /var/cache/apk/*

# Set default shell
SHELL ["/bin/bash", "-c"]

# # Optional: Add entrypoint script if needed
# # COPY entrypoint.sh /entrypoint.sh
# # RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash"]
#
# # Expose any necessary ports here if required by sidecar functionality
EXPOSE 8080
#
# # Add a health check to ensure the sidecar is responsive
# HEALTHCHECK --interval=30s --timeout=5s \
#     CMD curl -f http://localhost:8080/health || exit 1
#
