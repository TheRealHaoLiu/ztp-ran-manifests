#!/bin/bash

kubeconfig=$KUBECONFIG
GIT_HOST="https://gogs-svc-default.apps.izhang-hub-47-6np2g.dev10.red-chesterfield.com/testadmin/ztp-ran-manifests.git"
SUB_CMD="apply"

DEBUG="false"
DEBUG_FILES=("gitops-cluster-rolebinding.yaml" "app-project.yaml" "common-app.yaml")

while getopts "k:c:shd?" opt; do
    case "${opt}" in
    k)
        kubeconfig="${OPTARG}"
        ;;
    s)
        GIT_HOST="https://gogs-svc-default.apps.bm.rdu2.scalelab.redhat.com/testadmin/ztp-ran-manifests.git"
        ;;
    c)
        SUB_CMD="${OPTARG}"
        ;;
    d)
        DEBUG="true"
        echo
        echo "Running in debug mode, only ${DEBUG_FILES[@]} will be processed"
        ;;
    h | ? | *)
        echo
        echo "$(basename $0) will apply or delete argocd application by override the"
        echo "*yaml files in this dircrtory"
        echo
        echo "If runs in debug mode, then only ${DEBUG_FILES[@]} will be processed"
        echo
        echo "-k <kubeconfig path>, to specify your kubeconfig, default is KUBECONFIG"
        echo "-c <sub-command nmae>, to specify kubectl's subcommand, default is apply"
        echo "-d, flag will decide run in debug mode or not"
        echo "-s, flag let the script knows your are running againt scale-lab env"
        exit 0
        ;;
    esac
done

KUBECTL_CMD="oc --kubeconfig $kubeconfig --insecure-skip-tls-verify=true"

echo
echo "$(basename $0) runs at context: "
echo "$($KUBECTL_CMD config current-context)"
echo

if [ "$DEBUG" == "true" ]; then
    for file in ${DEBUG_FILES[@]}; do
        cat ./resources/$file | sed "s|GIT_HOST|${GIT_HOST}|" | $KUBECTL_CMD $SUB_CMD -f -
    done

    exit $#
fi

for file in $(ls ./resources); do
    cat ./resources/$file | sed "s|GIT_HOST|${GIT_HOST}|" | $KUBECTL_CMD $SUB_CMD -f -
done
