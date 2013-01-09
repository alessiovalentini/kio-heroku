##################################################################
# authenticate the databasedotcom client
##################################################################

puts "> authentication with username and password"

# generate client using heroku ENV vars and local export vars (see omniauth.rb) | :host when connecting to sandbox
@@client = Databasedotcom::Client.new :client_id => "3MVG9_7ddP9KqTzcZNlY7gQI32.qDwVMzUggPsH_nI_f0CrSaCdOX6.48GNV5Kgt4Us12NrkcrNdg7p7M1RLv", :client_secret => "1074214033172658342", :host => "test.salesforce.com"

# authenticate directly with username and password+security token (not using oauth)
@@client.authenticate :username => "alessio.valentini@kio.com.dev", :password => "Makepositive8602NrZJiWUlPa2fOsfGOL9fmcN"

puts "> instance url " + @@client.instance_url

# get news
News.getNews( 'null', 'null')