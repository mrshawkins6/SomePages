class Question < ActiveRecord::Base

	belongs_to :anketum
	
	validates :title, :presence => true
	
end
