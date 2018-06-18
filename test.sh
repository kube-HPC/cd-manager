echo Running tests - regressions!!!

# generate_post_data()
# {
#     local failed="$(cat failed.log)"
#     local failedNoNL="${failed//$'\n'/\\n}"
#     cat <<EOF
# {
#     "title":"CD test failed",
#     "body":"# Failed tests  \n${failedNoNL}  \n[Travis-ci logs](https://travis-ci.org/kube-HPC/cd-manager/jobs/${TRAVIS_JOB_ID})"
# }
# EOF
# }


# echo Running tests!!!
# export API_SERVER_IP=${KUBERNETES_MASTER_IP}
# export ELASTICSEARCH_IP=${KUBERNETES_MASTER_IP}
# export APAK_S3_FILES_PATH=http://minio1.kube-system.svc:9000/apak-data
# export APAK_OUTPUT_PATH=/ApakMCR/example_input_output

# # export TEST_FOLDER=$(mktemp -d)/system-test
# export TEST_FOLDER=/tmp/xxx/system-test
# export TEST_RESULTS=${TEST_FOLDER}/run_files/results/
# echo cloning system tests to ${TEST_FOLDER}
# mkdir -p ${TEST_FOLDER}
# git clone --depth=1 https://github.com/kube-HPC/system-test.git ${TEST_FOLDER}
# envsubst < ${TEST_FOLDER}/testConfigFiles/template/ipConfigs.template.csv > ${TEST_FOLDER}/testConfigFiles/ipConfigs.csv

# echo using config;
# cat ${TEST_FOLDER}/testConfigFiles/ipConfigs.csv
# docker run --rm -it --log-driver=none -a stdin -a stdout -a stderr -v /tmp/xxx/system-test:/system-test  hkube/jmeter:1.0.4 -c "cd /system-test/run_files; ./regression_indeviduals.sh" | tee ./out.log

# rc=${PIPESTATUS[0]}
# if [[ $rc != 0 ]]; then
#   echo FAILED
#   cat out.log
#   ls ${TEST_RESULTS}
#   awk "/The following tests has failed:/ { flag = 1 }; flag" out.log > filtered.log
#   echo -n > failed.log
#   for line in $(grep .jtl filtered.log); do
#     line=${line//$'\r'/''}
#     echo line: $line
#     echo ${line}>>failed.log
#     echo ====== Results for ${line} ======
#     cat ${TEST_RESULTS}${line}
#     echo ====== end results ======
#     echo
#   done
# #   echo "${FAILED}" | xargs -n 1 -i sh -c "echo ====== Results for {} ======; cat ${TEST_RESULTS}{}; echo ====== end results ======; echo"

#   echo "$(generate_post_data)"
#   curl -X POST -d "$(generate_post_data)" \
#     -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/kube-hpc/cd-manager/issues
# fi
# exit $rc
# # rm -rf ${TEST_FOLDER}

