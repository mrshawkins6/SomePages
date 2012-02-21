class Notebook < ActiveRecord::Base
	belongs_to :user
	has_many :anketum
	
	validates :description, :length => { :maximum => 500 }
end