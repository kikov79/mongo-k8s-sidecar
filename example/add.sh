#!/bin/bash


NUM_REPLICAS=$(kubectl get rc -l role=mongo -o template --template='{{ len .items }}')
NEW_REPLICA_NUM=$((NUM_REPLICAS + 1 ))

echo "Current Number of MongoDB Replicas: ${NUM_REPLICAS}"

echo 'Adding Replica'
sed -e "s~<num>~${NEW_REPLICA_NUM}~g" mongo-controller-template.yaml | kubectl create -f -
