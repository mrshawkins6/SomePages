class User < ActiveRecord::Base

	require 'digest'
	before_save :make_salt

	# Константы провайдеров
	VKONTAKTE = 1
	FACEBOOK = 2
	ODNOKLASSNIKI = 3
	
	# Константы полов
	MAIL = 0
	FEMAIL = 1
	
	# Регулярка для email
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# Связи
	has_many :notebooks
	
	# Атрибуты
	attr_accessor :status, :photo
	
	validates :provider,  :presence => true
	validates :provider_id, :presence => true
	validates :provider_id, :uniqueness => { :case_sensitive => false }
	#validates :email, :presence => false,
	#				:format   => { :with => email_regex },
	#				:uniqueness => { :case_sensitive => false }

	def initialize(attributes = {})
	
		@provider  = attributes[:provider]
		@status = attributes[:status]
	
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def self.authByKontakt(params, vkSession)
	
		provider_info = vkSession.getProfiles :uids => params[:viewer_id], :fields => "uid, first_name, last_name, sex, bdate, photo_medium, contacts, education, online, counters"
		
		provider_info = provider_info.first

		user = User.where(:provider_id => provider_info["user"]["uid"].to_i, :provider => VKONTAKTE).first
		
		if user == nil
		
			user = User.new({:provider => VKONTAKTE.to_i, :provider_id => provider_info["user"]["uid"].to_i, :first_name => provider_info["user"]["first_name"].to_s, :last_name => provider_info["user"]["last_name"].to_s})
			
			user.save
			
			first_title = "It's your first notebook"

			first_descr = "Keep it real!!!"
			
			first_notebook = Notebook.new({:user_id => user.id.to_i, :title => first_title.to_s, :description => first_descr.to_s})
			
			first_notebook.save
		
		end
		
		if params[:is_app_user] == 0
		
			user.status = false
		
		else
		
			user.status = true
		
		end
		
		user.photo = provider_info["user"]["photo_medium"]
		
		return user
		
	end
	
	private
	
		def make_salt
		
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{provider_id}")
		
		end
	
	
end
