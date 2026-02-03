# Quick Start Guide

## Setup (One-time)

1. **Get Windows 7 ISO**
   ```bash
   # Download Windows 7 ISO and place it at:
   ./iso/windows7.iso
   ```

2. **Open in VS Code**
   - Open this folder in VS Code
   - Click "Reopen in Container" when prompted
   - Wait for build to complete (~5-10 minutes first time)

3. **Start Windows**
   ```bash
   start
   ```

4. **Access Windows**
   - Open browser: http://localhost:8006
   - Or VNC client: localhost:5900
   - Or RDP (after Windows install): localhost:3389

## Daily Use

```bash
start      # Start the VM
stop       # Stop the VM
restart    # Restart the VM
logs       # View logs
```

## First Boot

1. Windows installation will begin automatically
2. Follow Windows 7 setup wizard in the web interface
3. Complete installation (takes 15-30 minutes)
4. VM state is saved in `./windows/` directory

## Tips

- The VM automatically saves state between starts
- Use `Ctrl+Alt+Delete` in web interface via the menu
- For better performance, ensure KVM is available: `ls -l /dev/kvm`
- Disk space is allocated on-demand (sparse files)

## Alternative: Use Pre-built Windows

Instead of installing from ISO, edit `windows/windows.yaml`:

```yaml
environment:
  VERSION: "win7"    # Downloads Windows 7 automatically
  # or
  VERSION: "win10"   # Windows 10
  VERSION: "win11"   # Windows 11
```

Then run `start`.
