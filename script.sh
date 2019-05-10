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
wget https://raw.githubusercontent.com/marcoaureliodeassuncao/Challenge/master/crypto_scrap2.py
wget https://raw.githubusercontent.com/marcoaureliodeassuncao/Challenge/master/scrap_dolar.py
mv crypto_scrap2.py crawler_crypto/crypto_scrap2.py
mv scrap_dolar.py crawler_dolar/scrap_dolar.py

# instalando pacotes python
sudo pip install bs4
sudo pip install lxml

# fazendo agendamento no crontab
crontab -l | { cat; echo "*/20 * * * * python ~/MarcoAssuncao/scrap_dolar.py"; } | crontab -
crontab -l | { cat; echo "*/20 * * * * python ~/MarcoAssuncao/crypto_scrap.py"; } | crontab -
crontab -l | { cat; echo "*/21 * * * * ~/put_to_hdfs.sh"; } | crontab -
