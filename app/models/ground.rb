class Ground < ActiveRecord::Base
   attr_accessible :groundName, :recordId, :latitude, :longitude

   # get the grounds from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getGrounds?lat=null&lng=null
   def self.get_grounds_from_salesforce
    	begin

			# prepare call
			endpoint = '/kio/v1.0/getGrounds'
			params   = '?' + 'lat=' + 'null' + '&lng=' + 'null'
			url      = @@client.instance_url + '/services/apexrest' + endpoint + params

			# log
			puts '> get grounds from salesforce:' + url

			# http call
			result   = @@client.http_get( url )

			if result.body.length != 0

				# deserialize
				parsed_json = ActiveSupport::JSON.decode(result.body)	#ActiveSuppor:: not required because already in the framework
				# transform to array with '=>'' instad of ':''
				result_news_list = JSON.parse(parsed_json)

				# create an object for each element of the array
				result_news_list.each do |object|
					# search if ground it's already present => if not save it
					if self.find_by_recordId(object['Id']) == nil
						# create a new ground using the model attribs
						new_ground = Ground.new(:recordId => object['Id'],
							                    :groundName => object['Name'],
							                    :latitude => object['Geolocation__Latitude__s'],
							                    :longitude => object['Geolocation__Longitude__s'])
						new_ground.save
						# log
						puts '> saved new ground ' + object.to_s
					else
						puts '> no new grounds to save'
					end
				end

			else
				# log
				puts '> no new grounds'
			end

		rescue Databasedotcom::SalesForceError => e
			puts '> error getting grounds' + e.message
		end
   end
end
