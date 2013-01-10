class Report < ActiveRecord::Base
  attr_accessible :abuseType, :address, :block, :description, :email, :groundId, :lat, :lng, :name, :otherGroundDescription, :otherGroundName, :phone, :recordId, :reportDate, :row, :seat

  # post a report to salesforce | https://<instance_url>/services/apexrest/kio/v1.0/newReport
  def post_report_batch_to_salesforce
  	# get batch from db

  	# stringify batch

  	# send batch

  	# if successfull delete the batch from the db

  end
end
