#!/bin/bash
export REPOSITORY=docker-windows

# Clean up any previous Docker processes
rm -f /var/run/docker.pid
rm -f /var/run/docker/containerd/containerd.pid

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

# Optimize network
ethtool --features eth0 rx-udp-gro-forwarding on 2>/dev/null || true
ethtool --features eth0 rx-gro-list off 2>/dev/null || true

# Setup swap
swapoff /tmp/swap 2>/dev/null || true
fallocate -l 8G /tmp/swap
chmod 600 /tmp/swap
mkswap /tmp/swap
swapon /tmp/swap

# Start Docker daemon
dockerd --seccomp-profile unconfined --experimental &> /dev/null &

# Wait for Docker to be ready
for i in {1..30}; do
    if docker info &> /dev/null; then
        echo "✅ Docker daemon is ready"
        break
    fi
    sleep 1
done

# Start simple HTTP server for ISO hosting if ISO exists
if [ -f /workspaces/$REPOSITORY/iso/windows7.iso ]; then
    cd /workspaces/$REPOSITORY/iso
    python3 -m http.server 8000 &> /dev/null &
    echo "✅ ISO server started on port 8000"
fi
