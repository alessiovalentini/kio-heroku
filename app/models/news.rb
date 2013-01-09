require 'uri'

class News < ActiveRecord::Base
    attr_accessible :body, :date, :newsImageUrl, :recordId, :title

  	# get the news from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getNews?delimitationDate=xx&latestOrMode=xx
	def self.get_news_from_salesforce
		begin
			# delimitation date is the date of the most recent news in the db
			last_news         = News.order('date ASC').first
			if( last_news )
				delimitation_date = URI.escape(last_news[:date].to_s)
				delimitation_date = delimitation_date[0...delimitation_date.length-6] # remove utc
			else
				delimitation_date = 'null'
			end

			# prepare call
			endpoint = '/kio/v1.0/getNews'
			params   = '?' + 'delimitationDate=' + delimitation_date + '&latestOrMore=' + 'latest'
			url      = @@client.instance_url + '/services/apexrest' + endpoint + params

			# log
			puts '> get news from salesforce:' + url

			# http call
			result   = @@client.http_get( url )

			if result.body.length != 0
				# deserialize
				parsed_json = ActiveSupport::JSON.decode(result.body)	#ActiveSuppor:: not required because already in the framework
				# transform to array with '=>'' instad of ':''
				result_news_list = JSON.parse(parsed_json)

				# create an object for each element of the array
				result_news_list.each do |object|
					self.create( object )
				end

				# log
				puts '> saved ' + result_news_list.length + 'news into the db'
			else
				# log
				puts '> no new news'
			end


		rescue Databasedotcom::SalesForceError => e
			puts '> error getting news' + e.message
		end
	end
end
