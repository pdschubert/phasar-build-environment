#!/bin/bash
set -e

#sudo apt-get update
sudo apt-get install git make cmake -y
#echo "-------------------------------------------"
#git --version
#echo "-------------------------------------------"
sudo apt-get install zlib1g-dev sqlite3 libsqlite3-dev python3 doxygen graphviz python3 python3-dev python3-pip libxml2 libxml2-dev libncurses5-dev libncursesw5-dev swig build-essential g++ cmake libedit-dev python3-sphinx libomp-dev libcurl4-openssl-dev ninja-build -y