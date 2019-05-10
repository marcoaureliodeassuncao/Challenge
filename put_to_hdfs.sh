#! /bin/bash

# criando diretórios no HDFS
hdfs dfs -mkdir /user/MarcoAssuncao
hdfs dfs -mkdir /user/MarcoAssuncao/input
hdfs dfs -mkdir /user/MarcoAssuncao/input/processados
hdfs dfs -mkdir /user/MarcoAssuncao/output
hdfs dfs -mkdir /user/MarcoAssuncao/output/transferidos

# Comando put dos arquivos .csv
hdfs dfs -put /user/MarcoAssuncao/scrapDolar.csv MarcoAssuncao/input
hdfs dfs -put /user/MarcoAssuncao/scrapCrypto.csv MarcoAssuncao/input

