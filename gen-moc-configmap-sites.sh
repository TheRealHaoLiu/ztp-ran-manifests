#!/bin/sh

START_INDEX=$1
END_INDEX=$2

PREFIX="sno"

#manifests/moc-sites/app1/prefix$1/$file_name
#
#app: manifests/moc-sites/app1{prefix 1:100}

APP_PREFIX="app"
APP_COUNTER="1"

template_dir=moc-site-configmap-template
generate_dir=manifests/moc-configmap-sites

rm -rf $generate_dir
for i in $(seq $START_INDEX $END_INDEX); do
    if [ $((i % 100)) -eq 0 ]; then
        ((APP_COUNTER += 1))
    fi

    idx=$(printf "%05g" $i)
    appIdx=$(printf "%03g" $APP_COUNTER)

    appPath="$generate_dir/$APP_PREFIX-$appIdx/$PREFIX$idx"
    mkdir -p $appPath

    for template_file in $(ls $template_dir); do
        file_name=$(echo $template_file | sed s/SITE/$PREFIX$idx/)
        cat $template_dir/$template_file |
            sed s/SITE/$PREFIX$idx/g > $appPath/$file_name
    done

done
