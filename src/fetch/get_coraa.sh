#!/usr/bin/env bash
#
# downloads CORAA dataset - https://github.com/nilc-nlp/CORAA
# script adapted from download_model.sh from ufpalign project
# 
# author: apr 2021
# cassio batista - https://cassota.gitlab.io
# last update: apr 2022

BASE_URL="https://drive.google.com/uc?export=download&"


# https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
declare -A files=(
  ["train.zip"]="1deCciFD35EA_OEUl0MrEDa7u5O2KgVJM"
  ["metadata_train_final.csv"]="1HbwahfMWoArYj0z2PfI4dHiambWfaNWg"
  ["dev.zip"]="1D1ft4F37zLjmGxQyhfkdjSs9cJzOL3nI"
  ["metadata_dev_final.csv"]="185erjax7lS_YNuolZvcMt_EdprafyMU0"
  ["test.zip"]="1vHH5oVo4zeJKchIyHHHjzvKD3QXuJxHZ"
  ["metadata_test_final.csv"]="1hcNoA7-xOEn5s0iYjX6BebaEsx_7LfCd"
)

# main
[ $# -ne 1 ] && echo "usage: $0 <data-dir>" && exit 1 || dir=$1
mkdir -p $dir || exit 1

for fname in train.zip metadata_train_final.csv dev.zip metadata_dev_final.csv test.zip metadata_test_final.csv ; do
  fhash=${files[$fname]}
  echo "$0: downloading $fname at $fhash"
  [ -f $dir/$fname ] && echo "$0: $fname exists under $dir. skipping..." && continue
  gdown -O $dir/$fname "$fhash" && [[ $fname == *.zip ]] && \
    { unzip -q $dir/$fname -d $dir/data || exit 1 ; }
done

echo "$0: success!"
