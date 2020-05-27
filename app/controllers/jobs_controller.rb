class JobsController < ApplicationController

  before_action :find_job, only: [:edit, :show, :update, :complete]

  def index

    if !current_user
      redirect_to user_session_path
    else
      @user = User.find(current_user.id)
      @punch = Punch.new
    end
    #git test 
  end

  def show
    @punch = Punch.new
  end 

  def new
    @job = Job.new
  end

  def create
    
    @job = Job.new(job_params)
    @job.creator = current_user
    if @job.save
      flash[:notice] = "A new job has been added"
      redirect_to jobs_path
    else
      render 'new'
    end

  end

  def edit; end

  def update

    if @job.update(job_params)
      flash[:notice] = "#{@job.name} has been updated"
      redirect_to job_path(@job)
    else
      render :edit
    end

  end

  def complete
      if @job.update(completed: true) 
        flash[:notice] = "#{@job.name} Job completed"
        redirect_back fallback_location: root_path  
      else
        flash[:error] = "#{@job.name} Job not completed"
      end
  end

  def restart
      @job = Job.find params[:id]
      if @job.update(completed: false) 
        flash[:notice] = "#{@job.name} Job restarted"
        redirect_back fallback_location: root_path 
      else
        flash[:error] = "#{@job.name} Job not started"
      end
  end

  def destroy
      @job = Job.find params[:id]
      @job.destroy
         respond_to do |format|
         format.html { redirect_to jobs_url, notice: 'User was successfully destroyed.' }
         format.json { head :no_content }
      end
   end

  private

  def job_params
    params.require(:job).permit(:name, :description, :notes, :status, :completed)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end
