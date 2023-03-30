#!/usr/bin/env bash
#
# prints the following stats table
# https://github.com/falabrasil/speech-datasets#stats
#
# author: oct 2021
# cassio batista - https://cassota.gitlab.io
# last update: may 2022


debug=false
div(){ for x in $(seq 140) ; do echo -n "-" ; done && echo ; }
msg(){
  printf "%-15s %5s %6s %8s %5s %8s %10s | %7s %5s %10s | %5s %5s %7s | %5s %5s %7s \n" \
    "$1" "$2" "$3" "$4" "$5" "$6" "$7" \
    "${8}"  "${9}"  "${10}" \
    "${11}" "${12}" "${13}" \
    "${14}" "${15}" "${16}"
}

for pack in sox python3 opusinfo ; do
  ! type -f $pack > /dev/null 2>&1 && \
    echo "$0: error: please install $pack" && exit 1
done

[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 || dir=$1
[ ! -d $dir ] && echo "$0: error: not a valid dir: $dir" && exit 1

div
printf "%-15s %47s | %24s | %19s | %19s \n" "dataset" "overall" "train" "dev" "test"
msg "" "size" "srate" "#utt" "#spk" "dur" "words" \
  "#utt" "#spk" "dur" \
  "#utt" "#spk" "dur" \
  "#utt" "#spk" "dur"
div
i=0
for data in voxforge cetuc coddef constituicao lapsbm lapsstory spoltech westpoint ; do
#for data in voxforge coddef lapsbm ; do
  data=$dir/$data
  # overall
  size=$(du -sh $data | cut -f 1)
  fs=$(find $data -name "*.wav" | xargs soxi -r | sort -u)
  nwav=$(find $data -name "*.wav" | wc -l)
  ntxt=$(find $data -name "*.txt" | wc -l)
  [ $(basename $data) == voxforge ] && \
    ntxt=$(find $data -name "prompts-original" | xargs cat | wc -l)
  [ $nwav -ne $ntxt ] && echo "$0: warn: #wav and #txt mistmatch on $data: $nwav $ntxt"
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
  msg $(basename $data) $size $fs $nutt $nspk $dur $nwords \
    $nwav_train $nspk_train $dur_train \
    $nwav_dev $nspk_dev $dur_dev \
    $nwav_test $nspk_test $dur_test
  i=$((i+1))
  $debug && [ $i -eq 3 ] && break
done
div

data=$dir/coraa
#overall
size=$(du -sh $data | cut -f 1)
fs=$(find $data -name "*.wav" | xargs soxi -r | sort -u)
nwav=$(find $data -name "*.wav" | wc -l)
ntxt=$(find $data -name "*.csv" | xargs tail -qn +2 | wc -l)  # header discount
[ $nwav -ne $ntxt ] && echo "$0: warn: #wav and #txt mistmatch on $data: $nwav $ntxt"
nutt=$nwav
nspk=-1  # unknown?
dur=$(find $data -name "*.wav" | xargs soxi -d | src/soxi2hours.py)
nwords=$(find $data -name "*.csv" | xargs tail -qn +2 | awk -F',' '{print $NF}' | wc -w)
# train
nwav_train=$(tail -qn +2 $data/metadata_train_final.csv | wc -l)
nspk_train=-1  # unknown?
dur_train=$(tail -qn +2 $data/metadata_train_final.csv | awk -F',' '{print $1}' | sed "s#^#$data/data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
# dev
nwav_dev=$(tail -qn +2 $data/metadata_dev_final.csv | wc -l)
nspk_dev=-1  # unknown?
dur_dev=$(tail -qn +2 $data/metadata_dev_final.csv | awk -F',' '{print $1}' | sed "s#^#$data/data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
# test
nwav_test=$(tail -qn +2 $data/metadata_test_final.csv | wc -l)
nspk_test=-1  # unknown?
dur_test=$(tail -qn +2 $data/metadata_test_final.csv | awk -F',' '{print $1}' | sed "s#^#$data/data/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
msg $(basename $data) $size $fs $nutt $nspk $dur $nwords \
  $nwav_train $nspk_train $dur_train \
  $nwav_dev $nspk_dev $dur_dev \
  $nwav_test $nspk_test $dur_test

# cv-corpus-8.0-2022-01-19
data=$dir/cv-corpus-8.0-2022-01-19
#overall
size=$(du -sh $data | cut -f 1)
fs=$(find $data -name "*.mp3" | xargs soxi -r | sort -u)
[ $(echo $fs | wc -w) -gt 1 ] && fs=*$(echo "$fs" | tail -n 1)
nwav=$(find $data -name "*.mp3" | wc -l)
ntxt=$(find $data -name "train.tsv" -o -name "dev.tsv" -o -name "test.tsv" | xargs tail -qn +2 | wc -l)  # header discount
[ $nwav -ne $ntxt ] && echo "$0: warn: #wav and #txt mistmatch on $data: $nwav $ntxt"
nutt=$nwav
nspk=$(find $data -name "train.tsv" -o -name "dev.tsv" -o -name "test.tsv" | xargs tail -qn +2 | awk '{print $1}' | sort -u | wc -l)
dur=$(find $data -name "*.mp3" | xargs soxi -d | src/soxi2hours.py)
nwords=$(find $data -name "train.tsv" -o -name "dev.tsv" -o -name "test.tsv" | xargs tail -qn +2 | cut -f3 | wc -w)
# train
nwav_train=$(find $data -name "train.tsv" | xargs tail -qn +2 | wc -l)
nspk_train=$(find $data -name "train.tsv" | xargs tail -qn +2 | awk '{print $1}' | sort -u | wc -l)
dur_train=$(find $data -name "train.tsv" | xargs tail -qn +2 | cut -f2 | sed "s#^#$data/pt/clips/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
# dev
nwav_dev=$(find $data -name "dev.tsv" | xargs tail -qn +2 | wc -l)
nspk_dev=$(find $data -name "dev.tsv" | xargs tail -qn +2 | awk '{print $1}' | sort -u | wc -l)
dur_dev=$(find $data -name "dev.tsv" | xargs tail -qn +2 | cut -f2 | sed "s#^#$data/pt/clips/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
# test
nwav_test=$(find $data -name "test.tsv" | xargs tail -qn +2 | wc -l)
nspk_test=$(find $data -name "test.tsv" | xargs tail -qn +2 | awk '{print $1}' | sort -u | wc -l)
dur_test=$(find $data -name "test.tsv" | xargs tail -qn +2 | cut -f2 | sed "s#^#$data/pt/clips/#" | xargs soxi -d 2>/dev/null | src/soxi2hours.py)
msg "cv 8.0" $size $fs $nutt $nspk $dur $nwords \
  $nwav_train $nspk_train $dur_train \
  $nwav_dev $nspk_dev $dur_dev \
  $nwav_test $nspk_test $dur_test

# mls
data=$dir/mls/data/mls_portuguese_opus
size=$(du -sh $data | cut -f 1)
fs=$(find $data -name "*.opus" | xargs opusinfo | grep -w 'Original sample rate' | cut -d':' -f2 | sed 's/Hz//g' | sort -u)
[ $(echo $fs | wc -w) -gt 1 ] && fs=*$(echo "$fs" | tail -n 1)
nwav=$(find $data -name "*.opus" | wc -l)
ntxt=$(find $data -name "transcripts.txt" | xargs cat | wc -l)
[ $nwav -ne $ntxt ] && echo "$0: warn: #wav and #txt mistmatch on $data: $nwav $ntxt"
nutt=$nwav
nspk=$(find $data -name "transcripts.txt" | xargs cat | awk -F'_' '{print $1$2}' | sort -u | wc -l)
dur=$(find $data -name "*.opus" | xargs opusinfo | grep -w 'Playback length' | awk '{print $NF}' | src/opus2hours.py)
nwords=$(find $data -name "transcripts.txt" | xargs cat | awk '{$1=""; print}' | wc -w)
# train
nwav_train=$(find $data/train -name "transcripts.txt" | xargs cat | wc -l)
nspk_train=$(find $data/train -name "transcripts.txt" | xargs cat | awk -F'_' '{print $1$2}' | sort -u | wc -l)
dur_train=$(find $data/train -name "*.opus" | xargs opusinfo | grep -w 'Playback length' | awk '{print $NF}' | src/opus2hours.py)
# dev
nwav_dev=$(find $data/dev -name "transcripts.txt" | xargs cat | wc -l)
nspk_dev=$(find $data/dev -name "transcripts.txt" | xargs cat | awk -F'_' '{print $1$2}' | sort -u | wc -l)
dur_dev=$(find $data/dev -name "*.opus" | xargs opusinfo | grep -w 'Playback length' | awk '{print $NF}' | src/opus2hours.py)
# test
nwav_test=$(find $data/test -name "transcripts.txt" | xargs cat | wc -l)
nspk_test=$(find $data/test -name "transcripts.txt" | xargs cat | awk -F'_' '{print $1$2}' | sort -u | wc -l)
dur_test=$(find $data/test -name "*.opus" | xargs opusinfo | grep -w 'Playback length' | awk '{print $NF}' | src/opus2hours.py)
msg "mls" $size $fs $nutt $nspk $dur $nwords \
  $nwav_train $nspk_train $dur_train \
  $nwav_dev $nspk_dev $dur_dev \
  $nwav_test $nspk_test $dur_test

# mtedx
data=$dir/mtedx/data/pt-pt/data
size=$(du -sh $data | cut -f 1)
fs=$(find $data -name "*.flac" | xargs soxi -r | sort -u)
[ $(echo $fs | wc -w) -gt 1 ] && fs=*$(echo "$fs" | tail -n 1)
nwav=$(find $data -name "*.flac" | wc -l)
ntxt=$(find $data -name "*.pt" | xargs cat | wc -l)
#[ $nwav -ne $ntxt ] && echo "$0: warn: #wav and #txt mistmatch on $data: $nwav $ntxt"
nutt=$ntxt
nspk=$(find $data -name "segments" | xargs cat | awk '{print $2}' | sort -u | wc -l)
dur=$(find $data -name "*.flac" | xargs soxi -d | src/soxi2hours.py)
nwords=$(find $data -name "*.pt" | xargs cat | sed 's/[,.:"!?]//g' | wc -w)
# train
nwav_train=$(find $data/train -name "*.pt" | xargs cat | wc -l)
nspk_train=$(find $data/train -name "segments" | xargs cat | awk '{print $2}' | sort -u | wc -l)
dur_train=$(find $data/train -name "*.flac" | xargs soxi -d | src/soxi2hours.py)
# dev
nwav_dev=$(find $data/valid -name "*.pt" | xargs cat | wc -l)
nspk_dev=$(find $data/valid -name "segments" | xargs cat | awk '{print $2}' | sort -u | wc -l)
dur_dev=$(find $data/valid -name "*.flac" | xargs soxi -d | src/soxi2hours.py)
# test
nwav_test=$(find $data/test -name "*.pt" | xargs cat | wc -l)
nspk_test=$(find $data/test -name "segments" | xargs cat | awk '{print $2}' | sort -u | wc -l)
dur_test=$(find $data/test -name "*.flac" | xargs soxi -d | src/soxi2hours.py)
msg "mtedx" $size $fs $nutt $nspk $dur $nwords \
  $nwav_train $nspk_train $dur_train \
  $nwav_dev $nspk_dev $dur_dev \
  $nwav_test $nspk_test $dur_test
