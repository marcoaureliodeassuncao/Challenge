from bs4 import BeautifulSoup
from datetime import datetime
import requests
import csv
import os

class ScrapDolar:
	def page(self):
		p = requests.get('https://m.investing.com/currencies/usd-brl', headers={'User-Agent':'curl/7.52.1'})
		return p

	def html(self,p):
		self.page = p
		soup = BeautifulSoup(self.page.content, 'html.parser')
		return soup

	def name(self, soup):
		s = soup
		self.scrap = s.find('div', {'class':'cryptoCurrentDataMain'})
		name = self.scrap.find('h1', {'class':'instrumentH1inlineblock'})
		return name.string.strip()

	def value(self,soup):
		s = soup
		self.scrap = s.find('div', {'class':'quotesBoxTop'})
		value = self.scrap.find('span',{'class':'lastInst pid-2103-last'})
		return value.string.strip()

	def change(self,soup):
		s = soup
		self.scrap = s.find('div',{'class':'quotesBoxTop'})
		change = self.scrap.find('span',{'class':'quotesChange'})
		valueChange = change.find('i',{'class':'greenFont pid-2103-pc'})
		if valueChange == None:
			valueChange = change.find('i',{'class':'redFont pid-2103-pc'})
		return valueChange.string.strip()

	def percent(self,soup):
		s = soup
		self.scrap = s.find('div',{'class':'quotesBoxTop'})
		span = self.scrap.find('span',{'class':'quotesChange'})
		percent = span.find('i',{'class':'parentheses greenFont pid-2103-pcp'})
		if percent == None:
			percent = span.find('i',{'class':'parentheses redFont pid-2103-pcp'})
		return percent.string.strip()

	def date(self,p):
		x = p
		date = datetime.now()
		return date

if __name__ == '__main__':
	scrap = ScrapDolar()
	url = scrap.page()
	html = scrap.html(url)

	with open('scrapDolar.csv','a+') as csvfile:
		f_size = os.path.getsize('scrapDolar.csv')
		csvwriter = csv.writer(csvfile,delimiter=';')
		if f_size == 0:
			csvwriter.writerow(['Coin', 'Currency', 'Change', 'Percentual', 'Timestamp'])
			csvwriter.writerow([scrap.name(html),scrap.value(html),scrap.change(html),scrap.percent(html),scrap.date(html)])
		else:
			csvwriter.writerow([scrap.name(html),scrap.value(html),scrap.change(html),scrap.percent(html),scrap.date(html)])
