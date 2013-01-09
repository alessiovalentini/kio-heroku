# load env vars from heroku env or local export
# locally:
# export DATABASEDOTCOM_CLIENT_ID=3MVG9_7ddP9KqTzcZNlY7gQI32.qDwVMzUggPsH_nI_f0CrSaCdOX6.48GNV5Kgt4Us12NrkcrNdg7p7M1RLv
# export DATABASEDOTCOM_CLIENT_SECRET=xxxxxxxxx
# heroku:
# heroku config:add DATABASEDOTCOM_CLIENT_ID=3MVG9_7ddP9KqTzcZNlY7gQI32.qDwVMzUggPsH_nI_f0CrSaCdOX6.48GNV5Kgt4Us12NrkcrNdg7p7M1RLv
# heroku config:add DATABASEDOTCOM_CLIENT_SECRET=xxxxxxxxx

# provider can change from salesforce to x

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :salesforce, ENV['DATABASEDOTCOM_CLIENT_ID'], ENV['DATABASEDOTCOM_CLIENT_SECRET']
end

############################################################################################
# notes
############################################################################################

# start authentication process with redirection to
# /auth/<provider> Ex: /auth/salesforce

# logout with redirection to
# signout_path
# where this path is defined in the router as
# match "/signout" => "authentications#signout", :as => :signout
# that uses the funtion authentications#signout of the authentication controller
# def logout
#   session[:user_id] = nil
#   redirect_to root_path
# end

# complete it using the router and a controller

# match "/auth/:provider/callback" => "authentications#callback_login"	where :provider is dynamic - ex should be a static salesforce
# match "/signout" => "authentications#signout", :as => :signout