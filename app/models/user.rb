class User < ActiveRecord::Base
	has_many :songs
	validates :email, presence: true
	validates :password, presence: true
end