class GaterController < ApplicationController

	require 'vk-ruby'
	APP_ID = 2782197
	APP_SECRET = 'u820kFrXOFGqlptrXxXX'

  def index
	
	@VKParam = 'boring!'
	
	vkApp = VK::Secure.new(:app_id => APP_ID, :app_secret => APP_SECRET)
	#puts vkApp
	if vkApp.authorize
	
	end
	#@VKParam= vkApp.isAppUser
	@VKParam = vkApp
  
  end
  
end
