# Use Ubuntu as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build tools including clang and Git tools
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    clangd \
    clang-tidy \
    cmake \
    gdb \
    valgrind \
    git \
    gnupg \
    openssh-client \
    nano \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create developer user with sudo privileges
RUN groupadd --gid 1000 developer \
    && useradd --uid 1000 --gid developer --shell /bin/bash --create-home developer \
    && echo developer ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer

# Set working directory
WORKDIR /workspace

# Set Clang as default compiler
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

# Switch to developer user
USER developer

# Set environment variables for Clang
ENV CC=clang
ENV CXX=clang++

# Default command
CMD ["/bin/bash"]
