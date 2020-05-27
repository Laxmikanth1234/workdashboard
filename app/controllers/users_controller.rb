class UsersController < ApplicationController
before_action :authenticate_user!

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def month
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end 
  end

  def create
    @user = User.new(params.require(:user).permit(:username , :password))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your account has been created."
      redirect_to root_path
    else
      render :new
    end
  end

end
