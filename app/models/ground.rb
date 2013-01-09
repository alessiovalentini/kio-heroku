class Ground < ActiveRecord::Base
  attr_accessible :groundName, :recordId, :latitude, :longitude

  # get the grounds from salesforce | https://<instance_url>/services/apexrest/kio/v1.0/getGrounds
  def self.get_grounds_from_salesforce
  end
end
