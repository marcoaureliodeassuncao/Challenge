#1 /bin/bash

hdfs dfs -get /user/MarcoAssuncao/output/Json/*.json .
mv *.json "/user/MarcoAssuncao/processados_json/$(date '+%Y%m%d').json"
