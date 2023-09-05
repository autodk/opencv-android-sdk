#!/bin/sh

export GROUP_ID=com.github.autodk
export ARTIFACT_ID=opencv-android-sdk

export VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: ./deploy.sh <new version>"
    exit 1
fi

allVersions=$(cat versions.txt)
if [[ $allVersions == *"$VERSION"* ]]; then
    echo "Version $VERSION already exists in versions.txt"
    exit 1
fi

./scripts/get-opencv-sdk.sh $VERSION
if [ $? -ne 0 ]; then
    echo "Failed to download OpenCV $VERSION"
    exit 1
fi

./scripts/build-opencv-sdk.sh $VERSION
if [ $? -ne 0 ]; then
    echo "Failed to build OpenCV $VERSION"
    exit 1
fi

echo "Moving ./com/github/autodk/opencv-android-sdk/${VERSION}/sdk-release.aar to ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.aar"
mv ./com/github/autodk/opencv-android-sdk/${VERSION}/sdk-release.aar ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.aar

echo "Creating ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.pom"
./scripts/expand-template.sh ./templates/pom.xml ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.pom

echo "Update hash files for ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.aar"
./scripts/update-hash.sh ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.aar

echo "Update hash files for ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.pom"
./scripts/update-hash.sh ./com/github/autodk/opencv-android-sdk/${VERSION}/${ARTIFACT_ID}-${VERSION}.pom

echo "Adding version $VERSION to versions.txt"
VERSIONS=$(cat versions.txt)
VERSIONS="$VERSIONS\n$VERSION"
echo "$VERSIONS" > versions.txt
sort -u versions.txt -o versions.txt

echo "Updating maven-metadata.xml"
VERSION=$(tail -n 1 versions.txt) VERSIONS=$(cat versions.txt) ./scripts/expand-template.sh ./templates/maven-metadata.xml ./com/github/autodk/opencv-android-sdk/maven-metadata.xml

echo "Updating maven-metadata.xml hash files"
./scripts/update-hash.sh ./com/github/autodk/opencv-android-sdk/maven-metadata.xml