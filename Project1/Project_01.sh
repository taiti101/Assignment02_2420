#!/bin/bash

# Checks if the script will be run as root
if [ "$EUID" -ne 0 ]; then 
   echo "Run as root"
   exit 1
else
   echo "Running as root."
fi

# A list of packages that will install 
packages=("kakoune" "tmux")

# This installs packages for each
for package in "${packages[@]}": do 
  pacman -S "$package"
  if [[ $? -ne 0 ]]; then
    echo "Failed to install $package"
  else
    echo "$package installed successfully"
  fi
done
