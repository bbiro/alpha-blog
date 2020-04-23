class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]  
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update]


  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
      @user = User.new

  end

  def create
      @user = User.new(user_params)
      if (@user.save)
          flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully sign up."
          session[:user_id] = @user.id
          redirect_to user_path(@user)
      else
          render 'new'
      end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if helpers.current_user != @user
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
    end
  end

end