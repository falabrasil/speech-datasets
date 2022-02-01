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

rm -f $dir/*.list $dir/*.list.spk
touch $dir/{train,dev,test}.list.spk

spk_list=$(mktemp --suffix='.list')
find $dir -mindepth 1 -maxdepth 1 -type d | \
  shuf --random-source=<(get_seeded_random) > $spk_list

n=$(wc -l < $spk_list)  # 100 %
g=M
held_list=$(mktemp --suffix='.list')
while read line ; do
  if [[ "$line" == *"_${g}0"* && $(wc -l < $held_list) -lt $((n / 5)) ]] ; then
    echo $line >> $held_list
    [[ "$g" == "M" ]] && g=F || g=M
  else
    echo $line >> $dir/train.list.spk
  fi
done < $spk_list

n=$(wc -l < $held_list) # 20 %
head -n $((n / 2))     $held_list > $dir/dev.list.spk   # 10%
tail -n $((n - n / 2)) $held_list > $dir/test.list.spk  # 10%

for spk_file in $dir/{train,dev,test}.list.spk ; do
  while read line ; do
    find $line -name "*.wav" >> ${spk_file%.spk}
  done < $spk_file
  rm -f $spk_file
done

echo "$0: done!"
wc -l $dir/*.list
rm -f $spk_list $held_list
