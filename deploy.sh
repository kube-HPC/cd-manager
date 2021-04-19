#!/bin/bash
echo Deploy to kubernetes
# source ./setPath
helm ls --all
helm repo add hkube-dev http://hkube.io/helm/dev/
helm repo update
envsubst < ./values-pub-template.yml > /tmp/pub.yml
VERSION=${VERSION:-latest}
# wait for version
if [ "$VERSION" != "latest" ]
then
    MAX_RETRY=20
    RETRY=0
    until [ "$RETRY" -ge "$MAX_RETRY" ]
    do
        RETRY=$((RETRY+1))
        FOUND=$(helm search repo hkube-dev/hkube --version $VERSION)
        echo $FOUND | grep $VERSION 
        NOT_FOUND=$?
        if [ $NOT_FOUND -eq 0 ]
        then
            echo found version $VERSION
            helm upgrade --wait --timeout 10m -i hkube -f /tmp/pub.yml hkube-dev/hkube --version $VERSION
            break
        fi
        echo version $VERSION not ready yet. Retry $RETRY of $MAX_RETRY in 30 seconds
        sleep 30
    done
    if [ $RETRY == $MAX_RETRY ]; then
      echo Failed to install $VERSION. Try running the action again
      exit 1
    fi
else
    helm search repo hkube-dev/hkube
    helm upgrade --wait --timeout 10m -i hkube -f /tmp/pub.yml hkube-dev/hkube
fi
helm ls --all

