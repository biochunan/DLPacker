#!/bin/zsh

# Aim: uncompress DLPacker_weights.7z file

# determine if 7z is installed, if not, sudo apt install p7zip-full p7zip-rar
if ! command -v 7z &> /dev/null
then
    echo "7z could not be found, installing p7zip-full p7zip-rar"
    sudo apt update && sudo apt install p7zip-full p7zip-rar -y
fi

pushd $(dirname $(realpath $0))
# uncompress DLPacker_weights.7z: this will automatically detect all subfiles and uncompress them
7z x DLPacker_weights.7z.001
