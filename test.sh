echo Running tests - short!!!
# CLUSTER_URL may or may not carry a scheme; normalise to exactly one
case "$CLUSTER_URL" in
  https://*|http://*) export BASE_URL="$CLUSTER_URL" ;;
  *) export BASE_URL="https://$CLUSTER_URL" ;;
esac
echo "resolved base url host: $(echo "$BASE_URL" | sed -E 's#^https?://##' | cut -d/ -f1)"
export TEST_FOLDER=/tmp/xxx/system-test-node
echo cloning system tests to ${TEST_FOLDER}
# persistent runner: the previous run's checkout would make git clone fail
rm -rf ${TEST_FOLDER}
mkdir -p ${TEST_FOLDER}
git clone --depth=1 https://github.com/kube-HPC/system-test-node.git ${TEST_FOLDER}
cd ${TEST_FOLDER}
npm ci
npm test
