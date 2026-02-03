#!/bin/bash
export REPOSITORY=docker-windows

# Setup directories
rm -rf /tmp/$REPOSITORY
mkdir -p /tmp/$REPOSITORY/windows
mkdir -p /workspaces/$REPOSITORY/windows
mkdir -p /workspaces/$REPOSITORY/iso

# Install helper scripts
cat > /usr/local/bin/start << 'EOF'
#!/bin/bash
cd /workspaces/docker-windows/windows && docker compose -f windows.yaml up -d
EOF

cat > /usr/local/bin/stop << 'EOF'
#!/bin/bash
cd /workspaces/docker-windows/windows && docker compose -f windows.yaml down
EOF

cat > /usr/local/bin/restart << 'EOF'
#!/bin/bash
cd /workspaces/docker-windows/windows && docker compose -f windows.yaml restart
EOF

cat > /usr/local/bin/kill << 'EOF'
#!/bin/bash
docker kill windows 2>/dev/null || true
EOF

cat > /usr/local/bin/remove << 'EOF'
#!/bin/bash
docker rm -f windows 2>/dev/null || true
EOF

cat > /usr/local/bin/logs << 'EOF'
#!/bin/bash
docker logs -f windows
EOF

chmod +x /usr/local/bin/{start,stop,restart,kill,remove,logs}

# Create docker-compose configuration for Windows 7
cat > /workspaces/$REPOSITORY/windows/windows.yaml << EOF
services:
  windows:
    container_name: windows
    image: dockurr/windows:latest
    environment:
      VERSION: "http://127.0.0.1:8000/windows7.iso"
      CPU_CORES: $(nproc --all)
      RAM_SIZE: $(($(free -g | awk '/^Mem:/{print $7}') - 2))G
      DISK_SIZE: $(df -BG /workspaces | grep '/workspaces' | awk '{print $4}')
      DISK2_SIZE: $(df -BG /tmp | grep '/tmp' | awk '{print $4}')
      KVM: Y
      DISPLAY: web
      DEBUG: Y
    ports:
      - 8006:8006/tcp
      - 8006:8006/udp
      - 5900:5900/tcp
      - 5900:5900/udp
      - 3389:3389/tcp
      - 3389:3389/udp
      - 8000:8000/tcp
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - ALL
    security_opt:
      - seccomp=unconfined
    volumes:
      - /workspaces/$REPOSITORY/windows:/storage
      - /tmp/$REPOSITORY/windows:/storage2
      - /workspaces/$REPOSITORY/iso:/iso
    privileged: true
    restart: on-failure
EOF

echo ""
echo "✅ Setup complete!"
echo ""
echo "To get started:"
echo "1. Download a Windows 7 ISO and place it in the ./iso directory as 'windows7.iso'"
echo "2. Run 'start' to launch the Windows VM"
echo "3. Access the web interface at http://localhost:8006"
echo ""
