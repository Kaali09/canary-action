#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config
kubectl get ns
# Execute kubectl command
ns=`kubectl get ns | grep confluent | xargs`
for i in $ns; do
echo "Listing pods in namespace: $i"
kubectl get po -n "$i"
done
