FROM debian:bookworm

# Install essential packages
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo privileges
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install XFCE and VNC
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tigervnc-standalone-server \
    tigervnc-common \
    dbus-x11 \
    novnc \
    websockify \
    x11-utils \
    xterm \
    firefox-esr \
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Install lvce editor
RUN wget https://github.com/lvce-editor/lvce-editor/releases/download/v0.71.15/lvce-v0.71.15_amd64.deb \
    && dpkg -i lvce-v0.71.15_amd64.deb || true \
    && apt-get update && apt-get install -f -y \
    && rm lvce-v0.71.15_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Set up VNC
RUN mkdir -p /home/$USERNAME/.vnc \
    && echo "vscode" | vncpasswd -f > /home/$USERNAME/.vnc/passwd \
    && chmod 600 /home/$USERNAME/.vnc/passwd \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.vnc

# Create xstartup script
RUN echo '#!/bin/sh\n\
unset SESSION_MANAGER\n\
unset DBUS_SESSION_BUS_ADDRESS\n\
exec startxfce4' > /home/$USERNAME/.vnc/xstartup \
    && chmod +x /home/$USERNAME/.vnc/xstartup \
    && chown $USERNAME:$USERNAME /home/$USERNAME/.vnc/xstartup

USER $USERNAME
WORKDIR /home/$USERNAME

# Set environment variables
ENV DISPLAY=:1

EXPOSE 5901 6080
