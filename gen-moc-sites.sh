#!/bin/sh

START_INDEX=$1
END_INDEX=$2

PREFIX="sno"

#manifests/moc-sites/app1/prefix$1/$file_name
#
#app: manifests/moc-sites/app1{prefix 1:100}

APP_PREFIX="app"
APP_COUNTER="1"

rm -rf manifests/moc-sites
for i in $(seq $START_INDEX $END_INDEX); do
    if [ $((i % 100)) -eq 0 ]; then
        ((APP_COUNTER += 1))
    fi

    idx=$(printf "%05g" $i)
    appIdx=$(printf "%03g" $APP_COUNTER)

    appPath="manifests/moc-sites/$APP_PREFIX-$appIdx/$PREFIX$idx"
    mkdir -p $appPath

    for template_file in $(ls moc-site-template); do
        vlan=$(($RANDOM % 4096))
        file_name=$(echo $template_file | sed s/SITE/$PREFIX$idx/)
        cat moc-site-template/$template_file |
            sed s/SITE/$PREFIX$idx/g |
            sed s/VLAN/$vlan/g \
                > $appPath/$file_name
    done

done
