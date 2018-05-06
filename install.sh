#!/bin/sh

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p ./bin
export PATH=$PWD/bin:$PATH
mv ./kubectl $PWD/bin/kubectl
echo ${KUBERNETES_MASTER_HOST} ${KUBERNETES_MASTER_IP} > ~/.hosts
export HOSTALIASES=~/.hosts
mkdir -p ~/.kube/
envsubst < ./kube-config-template.yml > ~/.kube/config
kubectl cluster-info
