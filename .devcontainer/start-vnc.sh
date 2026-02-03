#!/bin/bash

# Start VNC server
vncserver :1 -geometry 1920x1080 -depth 24 -localhost no -rfbport 5901

# Start noVNC websocket proxy in background
websockify -D --web=/usr/share/novnc/ 0.0.0.0:6080 localhost:5901

echo "VNC server started on :1 (port 5901)"
echo "noVNC web interface available on port 6080"
echo "VNC password: vscode"

# Keep script running
tail -f /dev/null
