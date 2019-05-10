#!/bin/bash

sudo yum update -y
sudo yum install python-pip
sudo easy_install pip==9.0.3
sudo pip install --upgrade pip

# criando diretórios no servidor
mkdir MarcoAssuncao
mkdir Marco/bin
mkdir MarcoAssuncao/crawler_crypto
mkdir MarcoAssuncao/crawler_crypto/processados
mkdir MarcoAssuncao/crawler_crypto/transferidos
mkdir MarcoAssuncao/crawler_dolar
mkdir MarcoAssuncao/crawler_dolar/transferidos
mkdir MarcoAssuncao/processados_json
mkdir MarcoAssuncao/processados_json/indexados

# baixando do git e movendo-os para seus respectivos diretórios
cd MarcoAssuncao
wget https://github.com/marcoaureliodeassuncao/Challenge/blob/master/MarcoAssuncao.zip?raw=true
unzip MarcoAssuncao.zip
mv MarcoAssuncao/crypto_scrap2.py ~/MarcoAssuncao/bin/crypto_scrap2.py
mv MarcoAssuncao/scrap_dolar.py ~/MarcoAssuncao/bin/scrap_dolar.py
mv MarcoAssuncao/scala_dir_2.11-0.1-SNAPSHOT.jar ~/MarcoAssuncao/bin/scala_dir_2.11-0.1-SNAPSHOT.jar
mv MarcoAssuncao/put_to_hdfs.sh ~/MarcoAssuncao/bin/put_to_hdfs.sh
mv MarcoAssuncao/submit.sh ~/MarcoAssuncao/bin/submit.sh
mv MarcoAssuncao/get_to_hdfs.sh ~/MarcoAssuncao/get_to_hdfs.sh
rm ~/MarcoAssuncao/MarcoAssuncao

# instalando pacotes python
sudo pip install bs4
sudo pip install lxml
sudo pip install itertools

# fazendo agendamento no crontab
crontab -l | { cat; echo "*/20 * * * * python ~/MarcoAssuncao/scrap_dolar.py"; } | crontab -
crontab -l | { cat; echo "*/20 * * * * python ~/MarcoAssuncao/crypto_scrap.py"; } | crontab -
crontab -l | { cat; echo "*/21 * * * * ~/MarcoAssuncao/put_to_hdfs.sh"; } | crontab -
crontab -l | { cat; echo "*/22 * * * * ~/MarcoAssuncao/submit.sh"; } | crontab -
crontab -l | { cat; echo "*/23 * * * * ~/MarcoAssuncao/get_to_hdfs.sh"; } | crontab -
