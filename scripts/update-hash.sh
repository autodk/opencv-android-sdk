#!/bin/sh
# This script is used to update the hash files (.md5, .sha1) of the input file
# Usage: ./update-hash.sh <input file>

if [ $# -ne 1 ]; then
    echo "Usage: ./update-hash.sh <input file>"
    exit 1
fi

input_file=$1
if [ ! -f $input_file ]; then
    echo "Input file $input_file does not exist"
    exit 1
fi

md5_file=$input_file.md5
md5sum $input_file | awk '{print $1}' > $md5_file
echo "Updated $md5_file with new hash value: `cat $md5_file`"

sha1_file=$input_file.sha1
sha1sum $input_file | awk '{print $1}' > $sha1_file
echo "Updated $sha1_file with new hash value: `cat $sha1_file`"

