# Dockerfile: Local test environment for the dotfiles installer.
# Usage:
#   docker build -t dotfiles-test .
#   docker run --rm -it dotfiles-test

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true
ENV DOTFILES_DIR=/root/dotfiles

# Install base dependencies available in Ubuntu to simulate a fresh machine.
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    sudo \
    zsh \
    build-essential \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Copy the repository into the container.
COPY . "$DOTFILES_DIR"

# Ensure scripts are executable.
RUN chmod +x "$DOTFILES_DIR/setup" "$DOTFILES_DIR/install" \
    "$DOTFILES_DIR/scripts/"* "$DOTFILES_DIR/os/"* \
    "$DOTFILES_DIR/bin/"* "$DOTFILES_DIR/modules/"*/install.sh 2>/dev/null || true

# Run the installer. Package installation is expected to be skipped on Linux.
RUN "$DOTFILES_DIR/install" || true

WORKDIR "$DOTFILES_DIR"
CMD ["/bin/bash"]
