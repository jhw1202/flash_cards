class User < ActiveRecord::Base
	validates :name, :presence => true
	validates :email, :uniqueness => true
	validates :email, :format => { :with => /[\w\.\-\_]+@[\w\-\.\_]{2,}\.[\w]{2,7}/ }

	has_many :rounds
	has_many :decks, :through => :rounds
end
