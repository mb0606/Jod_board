class Job < ActiveRecord::Base

	validates :title, :description, :company, :url, presence: true
end
