#!/usr/bin/env bash
#
# downloads Multilingual TEDx (mTEDx) - http://www.openslr.org/100/
# 
# author: dec 2021
# cassio batista - https://cassota.gitlab.io


[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1
dir=$1

mkdir -p $dir/data

fname=mtedx_pt.tgz
[ -f $dir/$fname ] && \
  echo "$0: file $fname exists under $dir. skipping download" || \
  { wget https://www.openslr.org/resources/100/$fname -P $dir || exit 1 ; }
tar xf $dir/$fname -C $dir/data || exit 1

echo "$0: success!"
