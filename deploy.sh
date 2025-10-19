#!/bin/bash
set -ex

domain="$1"
echo "Deploy to kubernetes"

# source ./setPath
helm ls --all
helm repo add hkube-dev "http://$domain/helm/dev/"
helm repo update

envsubst < ./values-pub-template.yml > /tmp/pub.yml
VERSION=${VERSION:-latest}

# wait for version if not 'latest'
if [ "$VERSION" != "latest" ]
then
    MAX_RETRY=20
    RETRY=0

    until [ "$RETRY" -ge "$MAX_RETRY" ]
    do
        RETRY=$((RETRY+1))

        helm repo update
        helm search repo hkube-dev/hkube

        # Check if version exists
        if helm search repo hkube-dev/hkube --version "$VERSION" | grep -q "$VERSION"; then
            echo "Found version $VERSION"
            helm upgrade --wait --timeout 10m -i hkube -f /tmp/pub.yml hkube-dev/hkube --version "$VERSION"
            break
        fi

        echo "Version $VERSION not ready yet. Retry $RETRY of $MAX_RETRY in 30 seconds"
        helm repo remove hkube-dev
        helm repo add hkube-dev "http://hkube.org/helm/dev/?$(xxd -l 4 -c 4 -p < /dev/random)"
        sleep 30
    done

    if [ "$RETRY" -eq "$MAX_RETRY" ]; then
        echo "Failed to install $VERSION. Try running the action again"
        exit 1
    fi
else
    helm search repo hkube-dev/hkube
    helm upgrade --wait --timeout 10m -i hkube -f /tmp/pub.yml hkube-dev/hkube
fi

helm ls --all
