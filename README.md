# Windows 7 in Docker using QEMU

Run Windows 7 in a Docker container using QEMU with VNC and web-based access. This setup uses Docker-in-Docker and the [dockur/windows](https://github.com/dockur/windows) image, inspired by [ItzLevvie/dind](https://github.com/ItzLevvie/dind).

## Features

- **QEMU with KVM acceleration**: High-performance virtualization
- **Docker-in-Docker**: Runs Windows in a nested Docker container
- **Multiple access methods**: Web UI, VNC, and RDP
- **Windows 7 support**: Bring your own ISO or use other Windows versions
- **Full hardware virtualization**: Uses `/dev/kvm` for better performance

## Prerequisites

- VS Code with Dev Containers extension
- Docker installed on your host machine
- KVM support (for hardware acceleration)
- Windows 7 ISO file (see [Where to get Windows 7 ISO](#where-to-get-windows-7-iso))

## Getting Started

### 1. Get a Windows 7 ISO

Download a Windows 7 ISO and place it in the `./iso/` directory with the name `windows7.iso`:

```bash
mkdir -p iso
# Place your Windows 7 ISO here as: ./iso/windows7.iso
```

**Where to get Windows 7 ISO:**

- Internet Archive has archived Windows 7 ISOs (search for "Windows 7 ISO")
- Microsoft's Software Recovery page (requires product key)
- Your organization's volume licensing portal

### 2. Open in VS Code

1. Open this folder in VS Code
2. When prompted, click "Reopen in Container" (or run: `Dev Containers: Reopen in Container`)
3. Wait for the container to build (first time takes ~5-10 minutes)

### 3. Start Windows VM

Once the devcontainer is ready, run:

```bash
start
```

This will:

- Pull the `dockurr/windows` Docker image
- Start QEMU with your Windows 7 ISO
- Set up VNC and web access

## Accessing Windows

### Web Interface (Recommended)

Open your browser to: **http://localhost:8006**

This provides a web-based console with mouse and keyboard support.

### VNC Client

Connect to: **localhost:5900**

Use any VNC client like TigerVNC, RealVNC, or TightVNC.

### Remote Desktop (RDP)

Once Windows is installed and RDP is enabled: **localhost:3389**

## Available Commands

| Command   | Description                     |
| --------- | ------------------------------- |
| `start`   | Start the Windows VM            |
| `stop`    | Stop the Windows VM gracefully  |
| `restart` | Restart the Windows VM          |
| `kill`    | Force stop the Windows VM       |
| `remove`  | Remove the Windows VM container |
| `logs`    | View Windows VM logs            |

## Configuration

The VM is configured in [`windows/windows.yaml`](windows/windows.yaml) with:

- **CPU Cores**: Uses all available cores
- **RAM**: Automatically allocated (total RAM - 2GB)
- **Disk**: Uses available workspace storage
- **KVM**: Enabled for hardware acceleration
- **Display**: Web interface on port 8006

### Customizing the VM

Edit [`windows/windows.yaml`](windows/windows.yaml) to change:

```yaml
environment:
  VERSION: "http://127.0.0.1:8000/windows7.iso" # ISO location
  CPU_CORES: 4 # Number of CPU cores
  RAM_SIZE: 8G # RAM allocation
  DISK_SIZE: 64G # Disk size
```

## Using Different Windows Versions

The `dockur/windows` image supports multiple Windows versions. Instead of using a custom ISO, you can use:

```yaml
VERSION: "win11"    # Windows 11
VERSION: "win10"    # Windows 10
VERSION: "win81"    # Windows 8.1
VERSION: "win7"     # Windows 7 (downloads automatically)
VERSION: "vista"    # Windows Vista
VERSION: "winxp"    # Windows XP
```

Just change the `VERSION` environment variable in `windows/windows.yaml` and restart.

## Troubleshooting

### Docker daemon not starting

If you see Docker errors, restart the devcontainer.

### KVM not available

If KVM is not available, the VM will fall back to slower emulation. To check KVM:

```bash
ls -l /dev/kvm
```

### ISO not found

Make sure your ISO is at `./iso/windows7.iso` and the filename matches exactly.

### Checking logs

```bash
logs
```

This shows the QEMU output and any errors.

## How It Works

1. **Docker-in-Docker**: The devcontainer runs a Docker daemon inside itself
2. **dockur/windows**: Uses the specialized Windows-in-Docker image
3. **QEMU**: Runs Windows in QEMU with KVM acceleration
4. **noVNC**: Provides web-based VNC access
5. **ISO hosting**: A simple HTTP server hosts your ISO file

## Credits

- Based on [dockur/windows](https://github.com/dockur/windows) by [Kroese](https://github.com/kroese)
- Inspired by [ItzLevvie/dind](https://github.com/ItzLevvie/dind)
- Uses Docker-in-Docker approach for GitHub Codespaces compatibility

## License

See [LICENSE](LICENSE)

- **Ports**: 5901 (VNC), 6080 (noVNC web)

## Stopping VNC

To stop the VNC server:

```bash
vncserver -kill :1
```
