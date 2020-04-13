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
    wget && \
	chmod g-s /usr/bin/screen && \
	chmod 1777 /var/run/screen

# install google chrome/chromedriver for integration tests https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/
# curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
# echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
# apt-get -y update
# apt-get -y install google-chrome-stable

# wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
# unzip chromedriver_linux64.zip
# mv chromedriver /usr/bin/chromedriver
# chown root:root /usr/bin/chromedriver
# chmod +x /usr/bin/chromedriver
# rm -f chromedriver_linux64.zip