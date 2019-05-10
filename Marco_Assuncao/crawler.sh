#! /bin/bash

python ~/MarcoAssuncao/bin/scrap_dolar.py
python ~/MarcoAssuncao/bin/crypto_scrap2.py
mv scrapCrypto.csv ~/MarcoAssuncao/crawler_crypto/scrapCrypto.csv
mv scrapDolar.csv ~/MarcoAssuncao/crawler_dolar/scrapDolar.csv
