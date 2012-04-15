task :environment do
  require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))
end

task :dictbuild => :environment do
	require 'rubygems'
	require 'mechanize'
	require 'pry'

	agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
	page = agent.get('http://en.wikipedia.org/wiki/Wikipedia:Recent_additions')

	fact_links = page.links_with(:href => %r(\/wiki\/Wikipedia:Recent_additions\/\d{4}))
	fact_links.each do |fact_page|

		facts = []

		#binding.pry
		page = agent.get "http://en.wikipedia.org" + fact_page.href
		facts = page.search("#bodyContent .mw-content-ltr ul li")

		dictionary = []


		facts.each do |fact|
			fact = fact.content
			next unless fact['...'] && !fact['Did you know'] && !fact['Wikinews']
			fact.gsub!("... that ","")
			fact.gsub!("...that ","")
			fact.chop!
			fact.gsub!(/\(.+\)/,"")
			dictionary.push(fact)
		end


	  File.open('config/dictionary.txt', 'a') do |f|
	  	dictionary.each do |fact|
	  		f.puts(fact)
	  	end
	  end
	end
end

task :tweet => :environment do
	@tweet = false
	until @tweet
  	candidate = MARK.sentence
  	if candidate.length < 140 && candidate.length > 80
  		@tweet = candidate
  	end
  end
  @tweet[0] = @tweet[0].upcase
  Twitter.update(@tweet)
end
