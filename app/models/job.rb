class Job < ActiveRecord::Base
	belongs_to :category

	validates :title, :description, :company, :url, presence: true
end
