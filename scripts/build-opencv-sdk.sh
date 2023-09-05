#!/bin/sh

version=$1

if [ -z "$version" ]; then
    echo "Usage: ./build-opencv-sdk.sh <version>"
    exit 1
fi

sdkDir=/tmp/opencv-${version}/OpenCV-android-sdk
if [ ! -d $sdkDir ]; then
    echo "OpenCV SDK directory $sdkDir does not exist"
    exit 1
fi

echo "Building OpenCV SDK $version in $sdkDir"
cp -rf ./gradle-settings/* $sdkDir
GRADLE_USER_HOME=/tmp/.gradle ./scripts/gradlew -p $sdkDir assemble -x lint
if [ $? -ne 0 ]; then
    echo "Failed to build OpenCV SDK $version"
    exit 1
fi

aarFile=$sdkDir/sdk/build/outputs/aar/sdk-release.aar
if [ ! -f $aarFile ]; then
    echo "Failed to build OpenCV SDK $version, $aarFile does not exist"
    exit 1
fi

echo "Copying $aarFile to ./com/github/autodk/opencv-android-sdk/${VERSION}/"
mkdir -p ./com/github/autodk/opencv-android-sdk/${VERSION}
cp -f $aarFile ./com/github/autodk/opencv-android-sdk/${VERSION}/

echo "Removing /tmp/opencv-${version}"
rm -rf /tmp/opencv-${version}
rm -rf /tmp/opencv-${version}.zip
