class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update]

# コントローラーで疑似的にnew_recordメソッドを変数として再現
# 新規投稿だと @isnew=true
# 既に投稿されていると　@isnew= falseを
# フォームを表示する全てのコントローラーに記述する

  def show
    @book_form = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])

  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    #↓が無いとBook loadという記述が無くなる
   @book = Book.find(params[:id])

    #↓が無いとBook Destroyという記述が無くなる
    @book.destroy

    #↓が無いとRedirected to という記述が無くなる
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
