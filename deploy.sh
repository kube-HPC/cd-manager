#!/bin/bash
echo Deploy to kubernetes
source ./setPath
helm repo add hkube http://hkube.io/helm
helm repo update

# hkube deploy --cluster_name=pub -c
# until $(curl -k --output /dev/null --silent --head --fail https://${KUBERNETES_MASTER_IP}/hkube/api-server/api/); do
#     printf '.'
#     sleep 5
# done
