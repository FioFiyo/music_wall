class Song < ActiveRecord::Base
	validates :title, presence: true, length: {maximum: 125}
	validates :author, presence: true, length: {maximum: 25}
	validates :url, presence: true
end