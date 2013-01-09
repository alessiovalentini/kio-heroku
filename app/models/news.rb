class News < ActiveRecord::Base
    attr_accessible :body, :date, :newsImageUrl, :recordId, :title

  	# get the news from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getNews
	def self.getNews( delimitationDate, latestOrMore )
		begin
			puts '> get news from salesforce'
			# Performs an HTTP GET request to the specified path (relative to self.instance_url).
			# Query parameters are included from parameters.
			# The required Authorization header is automatically included, as are any additional headers specified in headers.
			# Returns the HTTPResult if it is of type HTTPSuccess- raises SalesForceError otherwise.
			endpoint = '/kio/v1.0/getNews'
			params   = '?' + 'delimitationDate=' + delimitationDate + '&latestOrMore=' + latestOrMore
			url      = @@client.instance_url + '/services/apexrest' + endpoint + params

			# http call
			result   = @@client.http_get( url )
			# deserialize
			parsed_json = ActiveSupport::JSON.decode(result.body)
			# transform to array with '=>'' instad of ':''
			newsList    = JSON.parse(parsed_json)

			# create an object for each element of the array
			# newsList.each do |object|
			# 	self.create( object )
			# end

		rescue Databasedotcom::SalesForceError => e
			puts '> error getting news' + e.message
		end
	end
end
