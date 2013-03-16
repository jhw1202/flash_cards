class User < ActiveRecord::Base
	attr_reader :entered_password

	require 'bcrypt'

	before_create :bcrypt_password

	validates :name, :presence => true
	validates :email, :uniqueness => true
	validates :email, :format => { :with => /[\w\.\-\_]+@[\w\-\.\_]{2,}\.[\w]{2,7}/ }
	validate :entered_password, :length => { :minimum => 6 }

	has_many :rounds
	has_many :decks, :through => :rounds

  include BCrypt

  def bcrypt_password
  	@entered_password = @password
    self.password = Password.create(@password)
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if Password.new(@user.password) == password
      return @user
    end
    return nil
  end

end
