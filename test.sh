echo Running tests - short!!!
export BASE_URL=https://${KUBERNETES_MASTER_IP}
export TEST_FOLDER=/tmp/xxx/system-test-node
echo cloning system tests to ${TEST_FOLDER}
mkdir -p ${TEST_FOLDER}
git clone --depth=1 https://github.com/kube-HPC/system-test-node.git ${TEST_FOLDER}
cd ${TEST_FOLDER}
npm ci
npm test
