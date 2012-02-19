class GaterController < ApplicationController

	require 'digest/md5'
	
	VK_APP_ID = 2782197
	VK_APP_SECRET = 'u820kFrXOFGqlptrXxXX'

	def vkontakte

		if signed_in?
		
			redirect_to '/app'
		
		else		
					
			if params[:api_id] != nil && params[:viewer_id] != nil && params[:auth_key] != nil && params[:auth_key] == Digest::MD5.hexdigest(params[:api_id] + '_' + params[:viewer_id] + '_' + VK_APP_SECRET)

				session = ::VkApi::Session.new VK_APP_ID, VK_APP_SECRET

				user = User.authByKontakt(params, session)

				#sign_in user

				#redirect_to '/app'

				@User = user

			elsif params[:signed_request]


			else 

				redirect_to :action => 'fail'

			end
		
		end

	end
  
	def fail

		@Notebooks = User.find('1').notebooks.count

	end
  
end
