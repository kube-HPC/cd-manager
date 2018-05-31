
echo > failed.log
for line in $(grep .jtl filtered.log); do
    echo line is: ${line}
    echo ${line}>>failed.log
done
cat failed.log
# echo allLines: $allLines