#!/bin/sh

latestVersion=$(curl -s https://api.github.com/repos/opencv/opencv/releases/latest | grep tag_name | cut -d '"' -f 4)
if [ -z "$latestVersion" ]; then
    echo "Failed to get latest version from GitHub"
    exit 1
fi

echo "Latest version is $latestVersion"
if [ -f versions.txt ]; then
    allVersions=$(cat versions.txt)
    if [[ $allVersions == *"$latestVersion"* ]]; then
        echo "Version $latestVersion already exists in versions.txt"
        exit 0
    fi
fi

./deploy.sh $latestVersion
if [ $? -ne 0 ]; then
    echo "Failed to deploy OpenCV $latestVersion"
    exit 1
fi

git add .
git commit -m "$latestVersion"
git push
