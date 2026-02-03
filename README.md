# Docker XFCE DevContainer

This workspace includes a complete devcontainer setup with XFCE desktop environment and VNC access.

## Features

- **XFCE Desktop Environment**: Full-featured lightweight desktop
- **VNC Server**: Access desktop remotely via VNC client (port 5901)
- **noVNC Web Interface**: Access desktop via web browser (port 6080)
- **Full sudo privileges**: Run any `apt install` commands as needed

## Getting Started

1. Open this folder in VS Code
2. When prompted, click "Reopen in Container" (or run command: `Dev Containers: Reopen in Container`)
3. Wait for the container to build and start

## Accessing the Desktop

### Option 1: Web Browser (noVNC)

1. After the container starts, run the VNC start script:
   ```bash
   ./.devcontainer/start-vnc.sh
   ```
2. Open your browser to `http://localhost:6080`
3. Click "Connect" and enter password: `vscode`

### Option 2: VNC Client

1. Run the VNC start script:
   ```bash
   ./.devcontainer/start-vnc.sh
   ```
2. Connect your VNC client to `localhost:5901`
3. Use password: `vscode`

## Installing Packages

You have full sudo privileges, so you can install any package:

```bash
sudo apt update
sudo apt install <package-name>
```

## Configuration

- **VNC Password**: `vscode` (change in [.devcontainer/Dockerfile](.devcontainer/Dockerfile))
- **Screen Resolution**: 1920x1080 (change in [.devcontainer/start-vnc.sh](.devcontainer/start-vnc.sh))
- **Ports**: 5901 (VNC), 6080 (noVNC web)

## Stopping VNC

To stop the VNC server:

```bash
vncserver -kill :1
```
