#!/usr/bin/env bash
#
# splits dataset files into train, dev and test sets
#
# author: 2021
# cassio batista - https://cassota.gitlab.io

[ $# -ne 1 ] && echo "usage: $0 <corpus-dir>" && exit 1
dir=$1

rm -f $dir/*.list

find $1 -name "*-train.wav" > $dir/train.list
find $1 -name "*-test.wav"  > $dir/test.list

echo "$0: done!"
wc -l $dir/*.list
