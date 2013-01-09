class AuthenticationsController < ApplicationController

  #############################################################
  #   app starts => get authenticated
  #############################################################

  # def callback_login
  # 	# auth contains the user_id token instance_url
  # 	auth = request.env['omniauth.auth']

  # 	# this is saying that we have an open session
  # 	session[:user_id] = auth.user_id

  # 	# generate client using heroku ENV vars and local export vars (see omniauth.rb) | :host when connecting to sandbox
  #   client = Databasedotcom::Client.new :host => "test.salesforce.com"

  #   # authenticate the client with token and instance url obtained from omniouth
  #   clint.authenticate
  # end

  # def signout
  # 	session[:user_id] = nil
  # 	redirect_to root_path # => this will then
  # end

  # get records

  # deserialize

  # save them into the db

end
