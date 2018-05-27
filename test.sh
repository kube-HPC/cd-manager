echo Running tests!!!
export API_SERVER_IP=${KUBERNETES_MASTER_IP}
export ELASTICSEARCH_IP=${KUBERNETES_MASTER_IP}
export APAK_S3_FILES_PATH=http://minio1.kube-system.svc:9000/apak-data
export APAK_OUTPUT_PATH=/ApakMCR/example_input_output

# export TEST_FOLDER=$(mktemp -d)/system-test
export TEST_FOLDER=/tmp/xxx/system-test

echo cloning system tests to ${TEST_FOLDER}
mkdir -p ${TEST_FOLDER}
git clone --depth=1 https://github.com/kube-HPC/system-test.git ${TEST_FOLDER}
envsubst < ${TEST_FOLDER}/testConfigFiles/template/ipConfigs.template.csv > ${TEST_FOLDER}/testConfigFiles/ipConfigs.csv

echo using config;
cat ${TEST_FOLDER}/testConfigFiles/ipConfigs.csv
docker run --rm -it -v /tmp/xxx/system-test:/system-test  hkube/jmeter:v1.0.1 -c "cd /system-test/run_files; ./regression_indeviduals.sh"
# rm -rf ${TEST_FOLDER}