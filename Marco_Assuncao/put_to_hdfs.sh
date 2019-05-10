#! /bin/bash

# criando diretórios no HDFS
hdfs dfs -mkdir /user/MarcoAssuncao
hdfs dfs -mkdir /user/MarcoAssuncao/input
hdfs dfs -mkdir /user/MarcoAssuncao/input/processados
hdfs dfs -mkdir /user/MarcoAssuncao/output
hdfs dfs -mkdir /user/MarcoAssuncao/output/transferidos

# Comando put dos arquivos .csv
hdfs dfs -put MarcoAssuncao/crawler_dolar/scrapDolar.csv /user/MarcoAssuncao/input
hdfs dfs -put MarcoAssuncao/crawler_crypto/scrapCrypto.csv /user/MarcoAssuncao/input

# movendo csv's transferidos e comprimindo-os
mv MarcoAssuncao/crawler_dolar/scrapDolar.csv transferidos/scrapDolar.csv
zip -r $(date '+%Y%m%d').zip ~/MarcoAssuncao/scrapDolar.csv
mv MarcoAssuncao/crawler_crypto/scrapCrypto.csv transferidos/scrapCrypto.csv
zip -r $(date '+%Y%m%d').zip ~/MarcoAssuncao/scrapCrypto.csv
