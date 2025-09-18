#!/bin/bash
apt update
apt install unzip
apt install -y libcurl4-openssl-dev zlib1g-dev
cd /app/assets
unzip *.zip



