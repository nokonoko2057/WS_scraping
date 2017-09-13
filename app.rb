require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'open-uri'
require 'nokogiri'


get '/' do

end

get '/lit' do

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

get '/irasutoya' do
	@links = Array.new
	@imgs = Hash.new
	# url = 'http://www.irasutoya.com/search?q=テスト'
	url = 'http://www.irasutoya.com/search?q=hello'
	html = open(url).read
	parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
	i = 0
	# logger.info parsed_html.css('div#main').css('div.post-outer')
	# logger.info parsed_html.title

	parsed_html.css('div#main').css('div.post-outer').each do |node| #.css('div.boxim').css('a')
		anchor = node.css('div#post.box').css('div.boxim').css('a').css('script')
		logger.info anchor.text.match(/http.+png/)[0]
	end


end
