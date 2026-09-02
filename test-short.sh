echo Running tests - short!!!
export BASE_URL=https://${CLUSTER_URL}
export TEST_FOLDER=/tmp/xxx/system-test
echo cloning system tests to ${TEST_FOLDER}
mkdir -p ${TEST_FOLDER}
git clone --depth=1 https://github.com/kube-HPC/e2e-tests.git ${TEST_FOLDER}
cd ${TEST_FOLDER}
npm ci
npm test

