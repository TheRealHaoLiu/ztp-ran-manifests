#!/bin/sh

file="gitop-manifest-deployment.csv"

CONFIG=$KUBECONFIG
if [ -n "$1" ]; then
    CONFIG="$1"
fi

if [ ! -f ${file} ]; then
    echo "\
date,\
expected_placementrule_count,\
placementrule_count,\
expected_placementbinding_count,\
placementbinding_count,\
expected_policy_count,\
policy_count,\
expected_total_resource_count,\
total_resource_count\
" > ${file}
fi

export HISTO_DELAY=${HISTO_DELAY:-2}
echo "DELAY: ${HISTO_DELAY}"

#expected resource counts
expected_placementrule_count=$(find manifests -type f | grep placementrule | wc -l)
expected_placementbinding_count=$(find manifests -type f | grep placementbinding | wc -l)
expected_policy_count=$(find manifests -type f | grep -v placementrule | grep -v placementbinding | wc -l)
expected_total_resource_count=$(expr $expected_polacementrule_count + $expected_placementbinding_count + $expected_policy_count)

while [ true ]; do
    date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    placementrule_count=$(oc get placementrule -A --no-headers | wc -l)
    placementbinding_count=$(oc get placementbinding -A --no-headers | wc -l)
    policy_count=$(oc get policy -A --no-headers | wc -l)
    total_resource_count=$(expr $polacementrule_count + $placementbinding_count + $policy_count)

    echo "$date"
    echo "$date expected_placementrule_count    :$expected_placementrule_count"
    echo "$date placementrule_count             :$placementrule_count"
    echo "$date expected_placementbinding_count :$expected_placementbinding_count"
    echo "$date placementbinding_count          :$placementbinding_count"
    echo "$date expected_policy_count           :$expected_policy_count"
    echo "$date policy_count                    :$policy_count"
    echo "$date expected_total_resource_count   :$expected_total_resource_count"
    echo "$date total_resource_count            :$total_resource_count"
    
    echo "\
$date,\
$expected_placementrule_count,\
$placementrule_count,\
$expected_placementbinding_count,\
$placementbinding_count,\
$expected_policy_count,\
$policy_count,\
$expected_total_resource_count,\
$total_resource_count" >> ${file}

    sleep $HISTO_DELAY
done