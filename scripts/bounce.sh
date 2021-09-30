#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
mkdir -p ~/.kube
echo $kube_config | base64 -d > ~/.kube/config

# Execute kubectl command
kubectl get po -n $1
