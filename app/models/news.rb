class News < ActiveRecord::Base
    attr_accessible :body, :date, :newsImageUrl, :recordId, :title

  	# get the news from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getNews?delimitationDate=xx&latestOrMode=xx
	def self.getNews
		begin
			puts '> get news from salesforce'

			# delimitation date is the date of the most recent news in the db
			delimitationDate = 'null'

			# prepare call
			endpoint = '/kio/v1.0/getNews'
			params   = '?' + 'delimitationDate=' + delimitationDate + '&latestOrMore=' + 'more'
			url      = @@client.instance_url + '/services/apexrest' + endpoint + params

			# http call
			result   = @@client.http_get( url )
			# deserialize
			parsed_json = ActiveSupport::JSON.decode(result.body)
			# transform to array with '=>'' instad of ':''
			newsList    = JSON.parse(parsed_json)

			# create an object for each element of the array
			newsList.each do |object|
				puts object
				self.create( object )
			end

		rescue Databasedotcom::SalesForceError => e
			puts '> error getting news' + e.message
		end
	end
end
