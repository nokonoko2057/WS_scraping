require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'open-uri'
require 'nokogiri'

get '/' do

	@links = Array.new
	@imgs = Hash.new
	url = 'https://life-is-tech.com/'
	html = open(url).read
	parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
	i = 0
	# parsed_html.to_html
	parsed_html.css('ul.supporter-list').css('li').each do |node|
		anchor = node.css('a')
		# logger.info anchor.attribute('href').value  # ここまでURL取得
		# logger.info anchor.attribute('href').value.match(/https?:\/\/(?:www\.)?(?:jp\.)?(?:info\.)?(?:docs\.)?([^\.]*)/)[1]
		# ↑URLから企業名取得.正規表現学ぼう
		@links[i] = anchor.attribute('href').value.match(/https?:\/\/(?:www\.)?(?:jp\.)?(?:info\.)?(?:docs\.)?([^\.]*)/)[1]
		temp = anchor.css('img')
		temp.attribute('src').value = url + temp.attribute('src').value
		logger.info temp.to_html
		@imgs[@links[i]] = temp.to_html
		i = i + 1
	end
	erb :index
end
