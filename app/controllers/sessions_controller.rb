class SessionsController < ApplicationController

	#before_filter :require_signed_out, :except => [:destroy]

	require 'digest/md5'
	
	VK_APP_ID = 2782197
	VK_APP_SECRET = 'u820kFrXOFGqlptrXxXX'

	def vkontakte
	
		if !signed_in?
			
			session = ::VkApi::Session.new VK_APP_ID, VK_APP_SECRET

			begin

				user = User.authByKontakt(params, session)		

			rescue StandardError => detail
			
				@error = detail

				redirect_to '/pages'
			
			end

			sign_in user

			redirect_back_or_to user
			
		else
		
			#добавить проверку что пользователь пришел с нашей страницы
			
			redirect_to current_user
		
		end
		
	end

	def destroy
		sign_out
		#redirect_to root_path
	end
  
end
