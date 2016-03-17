#!/bin/bash


ENV=${ENV:-pre}
NUM_REPLICAS=$(kubectl get rc -l role=mongo -l environment=${ENV} -o template --template='{{ len .items }}')
NEW_REPLICA_NUM=$((NUM_REPLICAS + 1 ))


echo "Current Number of MongoDB Replicas: ${NUM_REPLICAS}"

echo 'Adding Replica'
sed -e "s~<num>~${NEW_REPLICA_NUM}~g" -e "s~<env>~${ENV}~g"  mongo-controller-template.yaml | kubectl create -f -
sed -e "s~<num>~${NEW_REPLICA_NUM}~g" -e "s~<env>~${ENV}~g"  mongo-service-template.yaml | kubectl create -f -
azure storage share create ${ENV}-mongo-${NEW_REPLICA_NUM}
