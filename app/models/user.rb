class User < ActiveRecord::Base

	require 'digest'
		
	# Атрибуты
	attr_accessor :status
	
	# attr_accessible, атрибуты для массового присвоения!
	attr_accessible :first_name, :last_name, :email, :password, :provider, :provider_id, :photo, :birthdate
	
	before_save :make_salt, :check_date

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
	has_many :notebooks, :dependent => :destroy
	has_many :anketum, :through => :notebooks
	has_many :questions, :through => :anketum
	
	validates :provider,  :presence => true
	validates :provider_id, :presence => true
	validates :provider_id, :uniqueness => { :case_sensitive => false }
	#validates :email, :presence => false,
	#				:format   => { :with => email_regex },
	#				:uniqueness => { :case_sensitive => false }
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def self.authByKontakt(params, vkSession)
	
		provider_info = vkSession.getProfiles :uids => params[:viewer_id], :fields => "uid, first_name, last_name, photo_medium"
		
		provider_info = provider_info.first
		
		vkUser = provider_info["user"]

		user = User.where(:provider_id => vkUser["uid"].to_i, :provider => VKONTAKTE).first
		
		if user == nil
		
			# если пользователь впервые зашёл в приложение
		
			user = User.new({:provider => VKONTAKTE.to_i, :provider_id => vkUser["uid"].to_i, :first_name => vkUser["first_name"].to_s, :last_name => vkUser["last_name"].to_s, :photo => vkUser["photo_medium"].to_s})
			
			user.save
			
			first_title = "It's your first notebook"

			first_descr = "Keep it real!!!"
			
			first_notebook = Notebook.new({:user_id => user.id.to_i, :title => first_title.to_s, :description => first_descr.to_s})
			
			first_notebook.save
			
		else
		
			if user.first_name != vkUser["first_name"].to_s || user.last_name != vkUser["last_name"].to_s || user.photo != vkUser["photo_medium"].to_s
			
				user.update_attributes(:first_name => vkUser["first_name"].to_s, :last_name => vkUser["last_name"].to_s, :photo => vkUser["photo_medium"].to_s)
			
			end
		
		end
		
		if params[:is_app_user] == 0
		
			user.status = false
		
		else
		
			user.status = true
		
		end

		user
		
	end
	
	def fullname
	
		fullname = self.first_name + " " + self.last_name
	
		return fullname
	
	end
	
	def self.create_with_omniauth(auth)
	  create! do |user|
		user.provider = VKONTAKTE.to_i
		user.provider_id = auth["uid"].to_i
		user.first_name = auth["first_name"].to_s
		user.last_name = auth["last_name"].to_s
		user.photo = auth["photo_medium"].to_s
	  end
	  
	  first_title = "It's your first notebook"

		first_descr = "Keep it real!!!"
		
		first_notebook = Notebook.new({:user_id => user.id.to_i, :title => first_title.to_s, :description => first_descr.to_s})
		
		first_notebook.save
	  
	end


	
	private
	
		def make_salt
		
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{provider_id}")
		
		end
	
end
