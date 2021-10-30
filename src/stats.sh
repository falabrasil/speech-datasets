#!/usr/bin/env bash
#
# author: oct 2021
# cassio batista - https://cassota.gitlab.io

debug=false
div() { for x in $(seq 125) ; do echo -n "-" ; done && echo ; }

for pack in sox python3 ; do
  ! type -f $pack > /dev/null 2>&1 && \
    echo "$0: error: please install $pack" && exit 1
done

[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 || dir=$1
[ ! -d $dir ] && echo "$0: error: not a valid dir: $dir" && exit 1

div
printf "%-15s %42s | %19s | %19s | %19s \n" "dataset" "overall" "train" "dev" "test"
printf "%-15s %5s %6s %6s %4s %7s %9s | %5s %5s %7s | %5s %5s %7s | %5s %5s %7s \n" \
  "" "size" "srate" "#utt" "#spk" "dur" "words" \
  "#utt" "#spk" "dur" "#utt" "#spk" "dur" "#utt" "#spk" "dur"
div
i=0
for data in $(find $dir -mindepth 1 -maxdepth 1 -type d | sort) ; do
  # overall
  size=$(du -sh $data | cut -f 1)
  fs=$(find $data -name "*.wav" | xargs soxi -r | sort -u)
  nwav=$(find $data -name "*.wav" | wc -l)
  ntxt=$(find $data -name "*.wav" | wc -l)
  [ $nwav -ne $ntxt ] && echo "$0: WARNING: #wav and #txt mistmatch"
  nutt=$nwav
  nspk=$(find $data/data -mindepth 1 -maxdepth 1 -type d | wc -l)
  dur=$(find $data -name "*.wav" | xargs soxi -d | src/soxi2hours.py)
  nwords=$(find $data -name "*.txt" | xargs cat | wc -w)
  # train
  nwav_train=$(wc -l 2>/dev/null < $data/train.list || echo "0")
  nspk_train=$(cut -d'/' -f2 $data/train.list 2>/dev/null | sort -u | wc -l || echo "0")
  dur_train=$(cat $data/train.list 2>/dev/null | sed "s#^#$data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
  # dev
  nwav_dev=$(wc -l 2>/dev/null < $data/dev.list || echo "0")
  nspk_dev=$(cut -d'/' -f2 $data/dev.list 2>/dev/null | sort -u | wc -l || echo "0")
  dur_dev=$(cat $data/dev.list 2>/dev/null | sed "s#^#$data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
  # test
  nwav_test=$(wc -l 2>/dev/null < $data/test.list || echo "0")
  nspk_test=$(cut -d'/' -f2 $data/test.list 2>/dev/null | sort -u | wc -l || echo "0")
  dur_test=$(cat $data/test.list 2>/dev/null | sed "s#^#$data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
  printf "%-15s %5s %6d %6d %4d %7s %9d | %5s %5s %7s | %5s %5s %7s | %5s %5s %7s \n" \
    $(basename $data) $size $fs $nutt $nspk $dur $nwords \
    $nwav_train $nspk_train $dur_train \
    $nwav_dev $nspk_dev $dur_dev \
    $nwav_test $nspk_test $dur_test
  i=$((i+1))
  $debug && [ $i -eq 3 ] && break
done
div
