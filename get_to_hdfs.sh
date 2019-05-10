#1 /bin/bash

#resgatar o json do HDFS
hdfs dfs -get /user/MarcoAssuncao/output/Json/*.json .
mv *.json "~/MarcoAssuncao/processados_json/$(date '+%Y%m%d').json"


#criar index no elastic

curl -XPUT 'http://localhost:9200/MarcoAssuncao/' -d '{
	"settings": {
		"index": {
			"number_of_shards": 1,
			"number_of_replicas": 0
		}
	}
}

curl -XPOST localhost:9200/MarcoAssuncao/_bulk -d '
	{"index": {}}
	{"~/MarcoAssuncao/processados_json/*.json"}
'


# movendo o json e zippando o arquivo
mv ~/MarcoAssuncao/processados_json/*.json ~MarcoAssuncao/processados_json/indexados/
zip -r $(date '+%Y%m%d'.zip ~MarcoAssuncao/processados_json/indexados/*.json

