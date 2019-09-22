#!/bin/bash -e
sudo apt update -y
sudo apt install -y git
git clone https://github.com/Sweeto143/scripts.git -b darkstar
bash scripts/setup/setup.sh
bash scripts/setup/ccache.sh
bash scripts/setup/ninja.sh
