#!/usr/bin/env bash
#
# author: dec 2021
# cassio batista - https://cassota.gitlab.io

CV_URL="https://mozilla-common-voice-datasets.s3.dualstack.us-west-2.amazonaws.com/cv-corpus-7.0-2021-07-21/cv-corpus-7.0-2021-07-21-pt.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&X-Amz-Date=20211204T135738Z&X-Amz-Expires=43200&X-Amz-Security-Token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&X-Amz-Signature=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&X-Amz-SignedHeaders=host"

msg() { echo -e "\e[93m[$(date)] $1\e[0m" ; }

s_date=$(date)

msg "$0: Downloading FalaBrasil's datasets from DVC's Google Drive public remote..."
dvc pull -r public

msg "$0: Downloading FalaBrasil's datasets from DVC's Google Drive private remote..."
dvc pull -r private

#msg "$0: Downloading FalaBrasil's male-female dataset for forced phonetic alignment from DVC's Google Drive private remote..."
#dvc pull -r align

msg "$0: Downloading Multilingual LibriSpeech..."
src/fetch/get_mls.sh datasets/mls

#msg "$0: Downloading SID..."
#src/fetch/get_sid.sh datasets

msg "$0: Downloading Multilingual TEDx..."
src/fetch/get_mtedx.sh datasets/mtedx

msg "$0: Downloading VoxForge..."
src/fetch/get_voxforge.sh datasets/voxforge

# FIXME
msg "$0: Downloading Common Voice..."
src/fetch/get_cv.sh "$CV_URL" datasets

msg "$0: Downloading CORAA..."
src/fetch/get_coraa.sh datasets/coraa

e_date=$(date)

msg "$0: success!"
echo $s_date
echo $e_date
