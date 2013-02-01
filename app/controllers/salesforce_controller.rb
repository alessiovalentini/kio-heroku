class SalesforceController < ApplicationController

	# get the news from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getNews
	def getNews( delimitationDate, latestOrMore )
		# Performs an HTTP GET request to the specified path (relative to self.instance_url).
		# Query parameters are included from parameters.
		# The required Authorization header is automatically included, as are any additional headers specified in headers.
		# Returns the HTTPResult if it is of type HTTPSuccess- raises SalesForceError otherwise.
		news = client.http_get( '/kio/v1.0/getNews?delimitationDate=' + delimitationDate + '&latestOrMore=' + latestOrMore )

		News.create
	end

	# get the grounds from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getGrounds
	def getGrounds( lat, lng )
		# return client.http_get(path, parameters = {}, headers = {})
	end

	# post a report to salesforce | https://<instance_url>/services/apexrest/kio/v1.0/newReport
	def newReport( reports_batch )
	end

end
