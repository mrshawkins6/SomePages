class Anketum < ActiveRecord::Base

	belongs_to :notebook
	has_many :questions

end
