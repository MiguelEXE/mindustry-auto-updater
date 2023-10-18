#!/bin/bash
if [ $(id -u) -ne 0 ]; then
    >&2 echo -e "\e[91mRun this command as sudo!\e[0m"
    exit 1
fi
download_url="https://github.com/MiguelEXE/mindustry-auto-updater/raw/master/mindustry.sh"

echo "Downloading mindustry auto updater."
wget -q --show-progress -O /usr/bin/mindustry $download_url
chmod +x /usr/bin/mindustry

echo -e "\e[92mDone! \e[97mRun \e[1m\`mindustry\`\e[0m\e[97m to start mindustry now!\e[0m"