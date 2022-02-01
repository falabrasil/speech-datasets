#!/usr/bin/env bash
#
# downloads VoxForge - http://www.voxforge.org/pt/downloads
# 
# author: dec 2021
# cassio batista - https://cassota.gitlab.io


[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 || dir=$1
mkdir -p $dir

# https://stackoverflow.com/questions/273743/using-wget-to-recursively-fetch-a-directory-with-arbitrary-files-in-it
# https://unix.stackexchange.com/questions/117988/wget-with-wildcards-in-http-downloads
wget -r -A "*.tgz" -R "index.*" -np -nH -nd -nc -q --show-progress \
  http://www.repository.voxforge1.org/downloads/pt/Trunk/Audio/Main/16kHz_16bit/ -P $dir || exit 1
for fname in $dir/*.tgz ; do
  mkdir -p $dir/$(basename ${fname%.tgz})
  tar xf $fname -C $dir/$(basename ${fname%.tgz}) || exit 1
done

echo "$0: success!"
