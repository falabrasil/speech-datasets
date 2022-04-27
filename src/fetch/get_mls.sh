#!/usr/bin/env bash
#
# downloads Multilingual LibriSpeech (MLS) - http://www.openslr.org/94/
# 
# author: dec 2021
# cassio batista - https://cassota.gitlab.io


[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 
dir=$1

mkdir -p $dir/data || exit 1

fname=mls_portuguese_opus.tar.gz
[ -f $dir/$fname ] && \
  echo "$0: file $fname exists under $dir. skipping download" || \
  { wget https://dl.fbaipublicfiles.com/mls/$fname -P $dir || exit 1 ; }
tar xf $dir/$fname -C $dir/data || exit 1

echo "$0: success!"
