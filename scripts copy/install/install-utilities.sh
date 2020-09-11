#!/bin/sh
apt-get update && \
  apt-get -qq install -y \
    git \
    curl \
    rsync \
    unzip \
    less \
    nano \
    vim \
    openssh-client \
    cmake \
    tmux \
    screen \
    gnupg \
    htop \
    wget && \
	chmod g-s /usr/bin/screen && \
	chmod 1777 /var/run/screen
