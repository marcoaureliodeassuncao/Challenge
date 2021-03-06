#!/bin/bash

sudo yum update -y
sudo yum install python-pip
sudo easy_install pip==9.0.3
sudo pip install --upgrade pip

# criando diretórios no servidor
mkdir ~/MarcoAssuncao
mkdir ~/MarcoAssuncao/bin
mkdir ~/MarcoAssuncao/crawler_crypto
mkdir ~/MarcoAssuncao/crawler_crypto/processados
mkdir ~/MarcoAssuncao/crawler_crypto/transferidos
mkdir ~/MarcoAssuncao/crawler_dolar
mkdir ~/MarcoAssuncao/crawler_dolar/transferidos
mkdir ~/MarcoAssuncao/processados_json
mkdir ~/MarcoAssuncao/processados_json/indexados

# baixando do git e movendo-os para seus respectivos diretórios
cd MarcoAssuncao
wget https://github.com/marcoaureliodeassuncao/Challenge/blob/master/Marco_Assuncao.zip?raw=true
unzip Marco_Assuncao.zip
mv ~/MarcoAssuncao/Marco_Assuncao/crawler.sh ~/MarcoAssuncao/bin/crawler.sh
mv ~/MarcoAssuncao/Marco_Assuncao/crypto_scrap2.py ~/MarcoAssuncao/bin/crypto_scrap2.py
mv ~/MarcoAssuncao/Marco_Assuncao/scrap_dolar.py ~/MarcoAssuncao/bin/scrap_dolar.py
mv ~/MarcoAssuncao/Marco_Assuncao/scala_dir_2.11-0.1-SNAPSHOT.jar ~/MarcoAssuncao/bin/scala_dir_2.11-0.1-SNAPSHOT.jar
mv ~/Marcoassuncao/Marco_Assuncao/put_to_hdfs.sh ~/MarcoAssuncao/bin/put_to_hdfs.sh
mv ~/MarcoAssuncao/Marco_Assuncao/submit.sh ~/MarcoAssuncao/bin/submit.sh
mv ~/MarcoAssuncao/Marco_Assuncao/get_to_hdfs.sh ~/MarcoAssuncao/bin/get_to_hdfs.sh
rm -rf ~/MarcoAssuncao/Marco_Assuncao

# instalando pacotes python
sudo pip install bs4
sudo pip install lxml
sudo pip install itertools

# fazendo agendamento no crontab
crontab -l | { cat; echo "*/20 * * * * ~/MarcoAssuncao/bin/crawler.sh"; } | crontab -
crontab -l | { cat; echo "*/21 * * * * ~/MarcoAssuncao//bin/put_to_hdfs.sh"; } | crontab -
crontab -l | { cat; echo "*/22 * * * * ~/MarcoAssuncao/bin/submit.sh"; } | crontab -
crontab -l | { cat; echo "*/23 * * * * ~/MarcoAssuncao/bin/get_to_hdfs.sh"; } | crontab -

