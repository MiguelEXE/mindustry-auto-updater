#!/bin/bash
if [ $(id -u) -ne 0 ]; then
    echo "Run this command as sudo!"
    exit 1
fi
download_url="github.com/MiguelEXE/mindustry-auto-updater/raw/master/mindustry.sh"

echo "Downloading mindustry auto updater."
wget -q --show-progress -O /usr/bin/mindustry $download_url
chmod +x /usr/bin/mindustry

echo "Done! run `mindustry` to start mindustry now!"