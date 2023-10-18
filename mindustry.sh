#!/bin/bash

mkdir -p ~/.mindustry
cd ~/.mindustry

echo -e "\e[90mFetching releases.\e[0m"
releases_json=$(curl -s https://api.github.com/repos/Anuken/Mindustry/releases)
latest_release_id=$(echo "$releases_json" | grep -m 7 "id" | tail +7 | sed 's/^[^:]*://;s/,//;s/ //g')
download_url=$(echo "$releases_json" | grep -m 1 "browser_download_url" | cut -d ":" -f2,3 | sed 's/"//g;s/ //g')
first_time_running_message=true

download(){
    echo -e "\e[32mDownloading Mindustry.jar\e[0m"
    rm -r Mindustry.jar 2> /dev/null
    wget -q --show-progress $download_url
    echo ""
}

if [ ! -f "Mindustry.jar" ] && [ -f "latest_id" ]; then
    rm -f latest_id
    first_time_running_message=false
fi

if [ -f latest_id ]; then
    diff latest_id <(echo "$latest_release_id") > /dev/null
    if [ $? -ne 0 ]; then
        echo -e "\e[1m\e[32mRelease $latest_release_id was released\e[0m\n"
        echo "$latest_release_id" > latest_id
        download
    else
        echo -e "\e[37mNo updates found. Skipping download.\e[0m\n"
    fi
else
    if [ $first_time_running_message = true ]; then
        echo -e "\e[1m\e[37mFirst time running.\e[0m\n"
    else
        echo -e "\e[1m\e[31mMindustry.jar was unexpectedly deleted.\e[0m\n"
    fi
    echo "$latest_release_id" > latest_id
    download
fi

echo -e "\e[90mLaunching mindustry...\e[0m"
exec java -jar Mindustry.jar
