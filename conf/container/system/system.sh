#!/bin/bash

# Install packages
apt-get update

# Install dev stuff
apt-get install --yes --no-install-recommends \
    build-essential make git ca-certificates openssl \
    wget curl llvm xz-utils tzdata

# Install pyenv stuff
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
apt-get install --yes --no-install-recommends \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install useful tools
apt-get install --yes --no-install-recommends vim

# Clean up
rm -rf /var/lib/apt/lists/*

# Setup app user
groupadd -g $SETUP_GID -o app
useradd --shell /bin/bash --system --create-home -u $SETUP_UID -g $SETUP_GID app
