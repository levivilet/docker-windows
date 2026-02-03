# Docker-in-Docker image for running Windows 7 in QEMU
FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    wget \
    ca-certificates \
    iptables \
    qemu-utils \
    p7zip-full \
    ethtool \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set iptables to legacy mode
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# Install Docker components
# Docker daemon
RUN wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-proxy -O /usr/local/bin/docker-proxy && \
    wget https://github.com/ItzLevvie/artifacts/releases/latest/download/dockerd -O /usr/local/bin/dockerd && \
    chmod +x /usr/local/bin/docker-proxy /usr/local/bin/dockerd

# Docker CLI
RUN wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-linux-amd64 -O /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

# Containerd
RUN wget https://github.com/ItzLevvie/artifacts/releases/latest/download/containerd-shim-runc-v2 -O /usr/local/bin/containerd-shim-runc-v2 && \
    wget https://github.com/ItzLevvie/artifacts/releases/latest/download/containerd -O /usr/local/bin/containerd && \
    chmod +x /usr/local/bin/containerd-shim-runc-v2 /usr/local/bin/containerd

# Runc
RUN wget https://github.com/ItzLevvie/artifacts/releases/latest/download/runc.amd64 -O /usr/local/bin/runc && \
    chmod +x /usr/local/bin/runc

# Docker Compose
RUN mkdir -p /usr/local/lib/docker/cli-plugins && \
    wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-compose-linux-x86_64 -O /usr/local/lib/docker/cli-plugins/docker-compose && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

WORKDIR /workspaces/docker-windows
