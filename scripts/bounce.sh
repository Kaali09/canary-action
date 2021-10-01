#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config


if [ $# -eq 0 ]; then
   ns=`kubectl get ns | grep confluent | awk '{print $1}'`
      for i in $ns; do
      echo "scaling down the deployment of $i"
         kubectl scale deployment nginx-deployment --replicas=0 -n $i
      done

      sleep 20

      for i in $ns; do
      echo "Scaling up the deployment of $i"
         kubectl scale deployment nginx-deployment --replicas=1 -n $i
      done

else
      echo "scaling down the deployment"
         kubectl scale deployment nginx-deployment --replicas=0 -n $1

      sleep 20
      echo "Scaling up the deployment"
         kubectl scale deployment nginx-deployment --replicas=1 -n $1
fi
