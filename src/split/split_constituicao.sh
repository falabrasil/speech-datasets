#!/usr/bin/env bash
#
# splits dataset files into train, dev and test sets
#
# author: 2021
# cassio batista - https://cassota.gitlab.io

SEED=0

# https://stackoverflow.com/questions/5914513/shuffling-lines-of-a-file-with-a-fixed-seed
function get_seeded_random() {
  openssl enc -aes-256-ctr -pass pass:"$SEED" -nosalt < /dev/zero 2> /dev/null
}

[ $# -ne 1 ] && echo "usage: $0 <corpus-dir>" && exit 1
dir=$1

rm -f $dir/*.list
touch $dir/{train,dev,test}.list

wav_list=$(mktemp --suffix='.list')
find $dir -name '*.wav' | shuf --random-source=<(get_seeded_random) > $wav_list

n=$(wc -l < $wav_list)  # 100 %
held_list=$(mktemp --suffix='.list')
head -n $((n / 5))     $wav_list > $held_list
tail -n $((n - n / 5)) $wav_list > $dir/train.list

n=$(wc -l < $held_list) # 20 %
head -n $((n / 2))     $held_list > $dir/dev.list   # 10%
tail -n $((n - n / 2)) $held_list > $dir/test.list  # 10%

echo "$0: done!"
wc -l $dir/*.list
rm -f $wav_list $held_list
