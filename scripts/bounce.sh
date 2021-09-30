#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config
# Execute kubectl command
if [ $# -eq 0 ]; then
ns=`kubectl get ns | grep kube | awk '{print $1}'`
for i in $ns; do
echo "Listing pods in namespace: $i"
kubectl get po -n "$i"
done

else
kubectl get po -n $1
echo "scaling down the deployment"
kubectl scale deployment nginx-deployment --replicas=0 -n $1

sleep 10
echo "Scaling up the deployment"
kubectl scale deployment nginx-deployment --replicas=1 -n $1

fi
