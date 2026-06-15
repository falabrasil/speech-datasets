#!/usr/bin/env bash
#
# author: july 2025
# Cassio T Batista - https://cassiotbatista.github.io

[ $# -ne 2 ] && >&2 echo "usage: $0 <dvc-data-dir> <hf-data-dir>" && exit 1
dvc_in_dir=$1
hf_out_dir=$2

[ ! -d $dvc_in_dir ] && \
    >&2 echo "$0: error: no such directory: $dvc_in_dir" && exit 1

echo "configs:"
echo "  - config_name: default"
echo "    data_files:"
for split_file in $dvc_in_dir/*.list ; do
    split_name=$(basename ${split_file%.list})
    echo >&2 "[$(date)] $0: info: processing $split_file..."
    echo "      - split: $split_name"
    echo "        path:"
    # create per-speaker subdirs
    cat $split_file | cut -d'/' -f2 | sort -u | \
        while read spkid ; do
            mkdir -p $hf_out_dir/$split_name/$spkid || exit 1
        done
    # copy *.wav and *.txt files to spk subdir
    while read wav ; do
        spkid=$(echo $wav | cut -d'/' -f2)  # cheaper than dirname/basename
        txt=${wav%.wav}.txt
        cp $dvc_in_dir/{$wav,$txt} $hf_out_dir/$split_name/$spkid
    done < $split_file
    # gunzip per-speaker subdirs
    cat $split_file | cut -d'/' -f2 | sort -u | \
        while read spkid ; do
            (
                cd $hf_out_dir/$split_name/$spkid
                rm -f $spkid.tar.gz
                tar zcf $spkid.tar.gz *
                cd - > /dev/null
            )
            rm $hf_out_dir/$split_name/$spkid/*.{wav,txt}
            echo "          - data/$split_name/$spkid/$spkid.tar.gz"
        done
done
echo >&2 "[$(date)] $0: info: success!"
