class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path
    else
      @books = Book.all
      render :index
    end
  end

  def edit
  end

  def destory
  end

  def update
  end

  def index
    @books = Book.all
  end

  def show
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
