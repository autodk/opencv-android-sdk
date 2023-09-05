#!/bin/sh

version=$1
if [ -z "$version" ]; then
    echo "Usage: ./get-opencv-sdk.sh <version>"
    exit 1
fi

downloadUrl="https://github.com/opencv/opencv/releases/download/${version}/opencv-${version}-android-sdk.zip"

echo "Downloading OpenCV SDK from $downloadUrl"
if [ -f /tmp/opencv-${version}.zip ]; then
    echo "File /tmp/opencv-${version}.zip already exists"
else
    curl -L -o /tmp/opencv-${version}.zip.tmp $downloadUrl
    if [ $? -ne 0 ]; then
        echo "Failed to download OpenCV SDK from $downloadUrl"
        exit 1
    fi
    mv /tmp/opencv-${version}.zip.tmp /tmp/opencv-${version}.zip
fi

echo "Extracting OpenCV SDK to /tmp/opencv-${version}"
if [ -d /tmp/opencv-${version} ]; then
    echo "Directory /tmp/opencv-${version} already exists"
else
    unzip -o -q /tmp/opencv-${version}.zip -d /tmp/opencv-${version}-tmp
    if [ $? -ne 0 ]; then
        echo "Failed to extract OpenCV SDK to /tmp/opencv-${version}"
        exit 1
    fi
    mv /tmp/opencv-${version}-tmp /tmp/opencv-${version}
fi
