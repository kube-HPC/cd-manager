#!/bin/bash
echo Deploy to kubernetes
# source ./setPath
helm repo add hkube-dev http://hkube.io/helm/dev/
helm repo update
envsubst < ./values-pub-template.yml > /tmp/pub.yml
helm search repo hkube
helm upgrade --wait --timeout 10m -i hkube -f /tmp/pub.yml hkube-dev/hkube
helm ls --all

