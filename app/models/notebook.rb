class Notebook < ActiveRecord::Base

	belongs_to :user
	has_many :anketum, :dependent => :destroy
	has_many :questions, :through => :anketum
	
	validates :title, :presence => true
	validates :description, :length => { :maximum => 500 }
end