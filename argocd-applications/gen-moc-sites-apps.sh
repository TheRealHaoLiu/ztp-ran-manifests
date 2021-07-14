#!/bin/bash

for appPath in $(ls ../manifests/moc-sites); do
    fullPath="manifests/moc-sites/$appPath"
    echo "$fullPath"
    cat moc-sites-app-template.yaml | sed -e "s|APP_PATH|$fullPath|" | sed -e "s|APP_NAME|$appPath|" > ./resources/moc-sites-$appPath.yaml
done
