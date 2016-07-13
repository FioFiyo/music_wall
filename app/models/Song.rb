class Song < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true, length: {maximum: 125}
	validates :author, presence: true, length: {maximum: 25}
	validates :url, presence: true
end