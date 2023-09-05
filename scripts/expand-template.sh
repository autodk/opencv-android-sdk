#!/bin/sh

# This script is used to expand the template file to the actual file using the
# variables defined in the template file and the values defined in the environment variables
# Usage: ./expand-template.sh <template file> <output file>

if [ $# -ne 2 ]; then
    echo "Usage: ./expand-template.sh <template file> <output file>"
    exit 1
fi

template_file=$1
if [ ! -f $template_file ]; then
    echo "Template file $template_file does not exist"
    exit 1
fi

output_file=$2
if [ -f $output_file ]; then
    rm -f $output_file
fi

value=$(eval "echo \"$(cat $template_file)\"")
echo "$value" > $output_file

echo "Expanded $template_file to $output_file"