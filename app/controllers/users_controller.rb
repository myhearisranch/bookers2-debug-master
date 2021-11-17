class UsersController < ApplicationController

  #他人のユーザ情報編集画面 遷移できず、自分のユーザ詳細画面にリダイレクトされる
  before_action :ensure_correct_user, only: [:update, :edit]



  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
       @user = User.find(params[:id])
       @books = @user.books
       @book = Book.new
      render "show"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    #他人のユーザ情報編集画面 遷移できず、自分のユーザ詳細画面にリダイレクトされる
    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

  end
