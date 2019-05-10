from requests import get
from bs4 import BeautifulSoup
from datetime import datetime
import csv
import os

#estabelece conexão com a url e retorna seu html
def page():
	res = get(url="https://m.investing.com/crypto/", headers={'User-Agent':'curl/7.52.1'})
	return res

#faz a captura de dados através do beautiful soup
def capturar_dados():
	page_url = page()
	soup = BeautifulSoup(page_url.text, 'lxml')
	crypto = soup.find_all('tr')
	return crypto

#faz uma lista com os dados capturados e os retorna
def listar_dados():
	crypto = capturar_dados()
	lista = []
	for coin in crypto:
		lista.append(coin.get_text().replace('\t','').split("\n"))
	return lista

#função data
def time_stamp():
	page_url = page()
	date = datetime.strptime(page_url.headers["Date"][:-4],'%a, %d %b %Y %H:%M:%S')
	return date

#dá o append na função data para dentro das listas de cada moeda e filtra os espaços '' das listas
def dados_completos():
	lista = listar_dados()
	date = time_stamp()
	coins = []
	for i in lista:
		i.append(date)
		coins.append(list(filter(None,i)))
	return coins

#gera um arquivo csv com as informações capturadas dando append a cada vez que roda o código
def gera_csv():
	with open('scrapCrypto.csv','a+') as csvfile:
		f_size = os.path.getsize('scrapCrypto.csv')
		if f_size == 0:
			csvwriter = csv.writer(csvfile,delimiter=';')
			for linha in dados_completos():
				csvwriter.writerow(linha)
		else:
			csvwriter = csv.writer(csvfile,delimiter=';')
			for linha in dados_completos()[1:]:
				csvwriter.writerow(linha)

if __name__ == "__main__":
	gera_csv()

