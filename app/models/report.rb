class Report < ActiveRecord::Base
  attr_accessible :abuseType, :address, :block, :description, :email, :groundId, :lat, :lng, :name, :otherGroundDescription, :otherGroundName, :phone, :recordId, :reportDate, :row, :seat

  # post a report to salesforce | https://<instance_url>/services/apexrest/kio/v1.0/newReport
  def self.post_reports_batch_to_salesforce

  	# get batch from db
  	local_report_batch = self.all

  	# prepare structure
  	batch_for_salesforce = {
  		:reportList => local_report_batch
  	}

  	# convert rails style to json
  	batch_for_salesforce = batch_for_salesforce.to_json

  	# prepare call
  	endpoint = '/kio/v1.0/newReport'
  	url      = @@client.instance_url + '/services/apexrest' + endpoint

	  # send batch
    result = @@client.http_post( url , data = batch_for_salesforce)

    puts result

  	# if successfull delete the batch from the db

  end
end
