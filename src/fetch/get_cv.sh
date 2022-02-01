#!/usr/bin/env bash
#
# author: dec 2021
# cassio batista - https://cassota.gitlab.io

[ $# -ne 2 ] && echo "$0: usage: $0 <url> <data-dir>" && exit 1
link="$(echo $1 | sed "s/=/\\=/g" | sed "s/&/\\&/g")"
dir=$2
[ ! -d $dir ] && echo "$0: dir does not exist: $dir" && exit 1

fname=cv-corpus-7.0-2021-07-21-pt.tar.gz
[ -f $dir/$fname ] && \
  echo "$0: file $fname exists under $dir. skipping download..." || \
  { wget $link -O $dir/$fname || exit 1 ; }
tar xf $dir/$fname -C $dir || exit 1

echo "$0: success!"
