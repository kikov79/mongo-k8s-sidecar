#!/bin/bash


ENV=${ENV:-pre}
NUM_REPLICAS=$(kubectl get rc -l role=mongo -l environment=${ENV} -o template --template='{{ len .items }}')
NEW_REPLICA_NUM=$((NUM_REPLICAS + 1 ))

echo "Current Number of MongoDB Replicas: ${NUM_REPLICAS}"

echo 'Deleting Replica'
kubectl delete svc ${ENV}-mongo-${NUM_REPLICAS}
kubectl delete rc ${ENV}-mongo-${NUM_REPLICAS}
