class GaterController < ApplicationController

	require 'digest/md5'
	
	VK_APP_ID = 2782197
	VK_APP_SECRET = 'u820kFrXOFGqlptrXxXX'

  def index
	
	if params[:api_id] && params[:viewer_id]
	
		vkAuthKey = Digest::MD5.hexdigest(params[:api_id] + '_' + params[:viewer_id] + '_' + VK_APP_SECRET)
		
		if params[:auth_key] == vkAuthKey

			redirect_to :action => 'vkontakte'
			
		end
	
	end
	
	redirect_to :action => 'vkontakte'
  
  end
  
  def vkontakte
  
  end
  
end
