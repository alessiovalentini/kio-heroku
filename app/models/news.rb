require 'uri'

class News < ActiveRecord::Base
    attr_accessible :body, :date, :newsImageUrl, :recordId, :title, :last_modified_date

  	# get the news from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getNews?delimitationDate=xx&latestOrMode=xx
	def self.get_news_from_salesforce
		begin
			# delimitation date is the date of the most recent news in the db
			last_news         = News.order('date DESC').first
			if( last_news )
				delimitation_date = last_news[:date].to_json # changed format to standard one
				delimitation_date = delimitation_date[1...delimitation_date.length-1] # fix
				# delimitation_date = URI.escape(last_news[:date].to_s)
				# delimitation_date = delimitation_date[0...delimitation_date.length-6] # remove utc
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

			# log
			puts '> get news call result: ' + result.body

			if result.body.length != 0
				# deserialize
				parsed_json = ActiveSupport::JSON.decode(result.body)	#ActiveSuppor:: not required because already in the framework
				# transform to array with '=>'' instad of ':''
				@result_news_list = JSON.parse(parsed_json)

				# # create an object for each element of the array
				# result_news_list.each do |object|
				# 	self.create( object )
				# end

				# insert or update new records
				self.insert_update_news

				# delete local records removed from the server
				self.delete_deleted_news

				# log
				puts '> saved ' + result_news_list.length.to_s + ' news into the db'	   # nb convert int to string
			else
				# log
				puts '> no new news'
			end


		rescue Databasedotcom::SalesForceError => e
			puts '> salesforce exception error getting news: ' + e.message
		end
	end


    def self.insert_update_news
    	###############################################################################
		# insert - update
		###############################################################################

		# ids array for delete
		@remote_server_record_ids = []
		# create an record for each element of the array
		@result_news_list.each do |remote_record|
			# build remote recordIds array
			@remote_server_record_ids<<remote_record['Id']
			# search if news is already present => if not save it
			local_record = self.find_by_recordId(remote_record['Id'])

			if local_record == nil
				# create a new news using the model attribs
				new_news = News.new(:recordId => remote_record['Id'],
					                    :title => remote_record['Title'],
					                    :body => remote_record['Body'],
					                    :date => remote_record['Date'],
										:newsImageUrl => remote_record['NewsImageUrl'],
										:last_modified_date => remote_record['LastModifiedDate'])
				new_news.save
				# log
				puts '> saved news ' + remote_record.to_s
			else
				# if local_record[:last_modified_date] < remote_record['LastModifiedDate']
				# 	# has been updated => update it
				# 	local_record.update_attributes!(:title => remote_record['Title'],
				# 					                    :body => remote_record['Body'],
				# 					                    :date => remote_record['Date'],
				# 										:newsImageUrl => remote_record['NewsImageUrl'],
				# 										:last_modified_date => remote_record['LastModifiedDate'])
				# 	# log
				# 	puts '> updated news ' + remote_record.to_s
				# end
			end
		end
    end

    def self.delete_deleted_news
	    ###############################################################################
		# delete
		###############################################################################

		# search for removed (or unpublished) records
		local_record_list = News.all
		result_news_list_size = @result_news_list.length
		local_record_list_size  = local_record_list.length

		# if local records number not greater than remote we don't have to delete
		if local_record_list_size > result_news_list_size
			# local recordIds array with parallel internal record ids array
			local_server_record_ids  = []       # remote_server_record_ids generated before
			local_internal_record_ids = []		# parallelal hash structure to save corrispondent internal id for fast delete
			local_record_list.each do |local_record|
				local_server_record_ids<<local_record[:recordId]
				local_internal_record_ids<<{ :server_id => local_record[:recordId], :internal_id => local_record[:id] } # to speed up deletion
			end

			# difference to find record to be deleted
			to_be_removed_server_record_ids = local_server_record_ids - @remote_server_record_ids

			# if there is a difference => remove
			if to_be_removed_server_record_ids.length > 0
				# get the array of internal record ids for removal
				to_be_removed_internal_record_ids = []
				to_be_removed_server_record_ids.each do |server_id_to_be_removed|
					# find the internal id using server id and parallel hash structure
					local_internal_record_ids.each do |element|
						if element[:server_id] == server_id_to_be_removed
							to_be_removed_internal_record_ids<<element[:internal_id]
						end
					end
				end

				# delete using array of ids
				News.delete( to_be_removed_internal_record_ids )

				# log
				puts '> removed news with internal ids ' + to_be_removed_internal_record_ids.to_s
			end
		end
    end
end
