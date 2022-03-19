class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]
  # now only admins can delete accounts ^^

    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user, notice: "Thanks for signing up!"
      else
        render :new
      end
    end

    def edit

    end

    def update

      if @user.update(user_params)
        redirect_to @user, notice: "User successfully updated!"
      else
        render :edit
      end
    end

    # def destroy
    #   @user.destroy
    #   session[:user_id] = nil
    #   redirect_to movies_url, alert: "Account successfully deleted!"
    # end
    # code before only admins were allowed to delete users ^

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to root_url, alert: "Account successfully deleted!"
    end
    # replacement code allowing only admins to delete users ^
  
  private
    def user_params
      params.require(:user).
        permit(:name, :email, :password, :password_confirmation, :username)
    end

    def require_correct_user
      @user = User.find(params[:id])
      # ^ removes duplicated code in edit update and delete actions since this method must run before those actions
      redirect_to root_url unless current_user?(@user)

      # unless current_user?(@user)
      #   redirect_to root_url
      # end

    end


  end
  # ^^^^ Reminder to put private methods in the class not outside of it!