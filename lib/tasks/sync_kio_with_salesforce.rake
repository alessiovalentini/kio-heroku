
desc "This task syncs the app with salesforce every 1 hour"
task :sync_kio_with_salesforce => :environment do

	News.get_news_from_salesforce
	Ground.get_grounds_from_salesforce
	# Report.post_reports_batch_to_salesforce
end
