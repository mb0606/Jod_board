class JobsController < ApplicationController

	before_action :find_job, except: [:index, :new, :create]

	def index
		if params[:category].blank?
			@jobs = Job.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@category = Category.find_by(id: @category_id)
			@jobs = Job.where(category_id: @category_id).order("created_at DESC")
		end
	end

	def show 
		@category = Category.find(@job.category_id)

	end

	def new 
		@job = Job.new

	end

	def create
		@job = Job.new(jobs_params)

		if @job.save
			flash[:success] = "Job has successfully saved"
			redirect_to @job
		else
			flash[:error] = "Job not saved"
			render 'new'
		end
	end

	def edit 

	end

	def update
		if @job.update(jobs_params)
			flash[:success] = "Job has successfully been updated"
			redirect_to @job
		else
			flash[:error] = "Job has not been updated"
			render "edit"
		end
	end

	def destroy
		if @job.destroy
			flash[:success] = "The Job was deleted"
			redirect_to root_path
		else
			flash[:error] = "Job was not deleted"
			redirect_to @job
		end
	end

	private

	def jobs_params
		params.require(:job).permit(:title, :description, :company, :url, :category_id)
	end

	def find_job
		@job = Job.find(params[:id])
	end
end
