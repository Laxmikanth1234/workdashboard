class ClocksController < ApplicationController
  before_action :get_user

  def clock_in
    #binding.pry
    

      #time_since_last_punch = Time.now.getutc - last_punch

    @clock = Clock.create(user: @user)		

    if @clock.save
      flash[:notice] = "Hey!! #{@clock.user.username} You Clocked In at #{@clock.created_at.strftime('%r')} "
      redirect_back fallback_location: root_path  
    else
        render 'jobs/index'
    end
  end

  def clock_out
    #binding.pry
    clock = @user.current_clock_in
    

    if @user.current_clock_in && clock.update(clock_out: Time.now)
      flash[:notice] = "Hey!! #{clock.user.username} You Clocked Out at #{clock.clock_out.strftime('%r')} "
      redirect_back fallback_location: root_path  
    else
        flash[:error] = "You are not Clocked in, so you can't clocks out."
        redirect_back fallback_location: root_path
    end


  end

  def index
  	 @clocks = Clock.all
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
  	
end
