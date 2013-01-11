class Report < ActiveRecord::Base
  attr_accessible :abuseType, :address, :block, :description, :email, :groundId, :lat, :lng, :name, :otherGroundDescription, :otherGroundName, :phone, :recordId, :reportDate, :row, :seat

  # post a report to salesforce | https://<instance_url>/services/apexrest/kio/v1.0/newReport
  def self.post_reports_batch_to_salesforce

  	# get batch from db
  	local_report_batch = self.all

    if local_report_batch.count > 0

    	# prepare structure
    	batch_for_salesforce = {
    		:reportList => local_report_batch
    	}

    	# convert rails style to json
    	batch_for_salesforce = batch_for_salesforce.to_json

    	# prepare call
    	endpoint = '/kio/v1.0/newReport'
    	url      = @@client.instance_url + '/services/apexrest' + endpoint

      begin
    	  # send batch
        result = @@client.http_post( url , data = batch_for_salesforce)

        # if successfull delete the batch from the db
        if result.body == '"Success"' # NOTE salesforce is returning not Success but "Success"
          # success => remove the submitted records from local db
          Report.destroy( local_report_batch )
          puts '> successfully sent reports to salesforce. deleted records from heroku db'
        else
          puts '>>> salesforce responded without success sending reports to it. records are kept in the db for the next try [result and result.body]'
          puts result
          puts result.body
          puts '<<<'
        end

      rescue Databasedotcom::SalesForceError => e
        puts '> salesforce exception error submitting reports to salesforce: ' + e.message
      end
    else
      puts '> no reports to send to salesforce'
    end
  end
end
