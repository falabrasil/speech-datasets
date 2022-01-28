#!/usr/bin/env bash
#
# downloads CORAA dataset - https://github.com/nilc-nlp/CORAA
# script adapted from download_model.sh from ufpalign project
# 
# author: apr 2021
# cassio batista - https://cassota.gitlab.io
# last update: dec 2021

BASE_URL="https://drive.google.com/uc?export=download&"


# https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
declare -A files=(
  ["train.zip"]="1deCciFD35EA_OEUl0MrEDa7u5O2KgVJM"
  ["metadata_train_final.csv"]="1HbwahfMWoArYj0z2PfI4dHiambWfaNWg"
  ["dev.zip"]="1bIHctanQjW2ITOM5wNQSt_NjB45s0_Q_"
  ["metadata_dev_final.csv"]="185erjax7lS_YNuolZvcMt_EdprafyMU0"
)

# https://stackoverflow.com/questions/48133080/how-to-download-a-google-drive-url-via-curl-or-wget/48133859
fetch() {
  fname="$1"
  fhash="$2"
  echo "$0: downloading '$fname' from Google Drive"
  curl -c  ./cookie -s -L "$BASE_URL&id=$fhash" > /dev/null
  curl -L --progress-bar -b ./cookie \
    "$BASE_URL&confirm=$(awk '/download/ {print $NF}' ./cookie)&id=$fhash" \
    -o $fname || exit 1
}

# main
[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 || dir=$1
mkdir -p $dir || exit 1

trap 'rm -f cookie' SIGINT

for fname in train.zip metadata_train_final.csv dev.zip metadata_dev_final.csv ; do
  fhash=${files[$fname]}
  [ -f $dir/$fname ] && \
    echo "$0: file $fname exists under $dir. skipping download" || \
    { fetch $fname $fhash && mv $fname $dir ; }
  [[ $fname == *.zip ]] && unzip -q $dir/$fname -d $dir || exit 1
done

rm -f cookie
echo "$0: success!"
