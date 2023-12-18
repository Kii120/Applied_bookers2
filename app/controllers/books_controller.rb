class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new

    # sortを使って並べ替え
    # .sortは-1が来たら要素を逆転させる．
    # b <=> a は, b < aの時に-1, b > aの時に1, b = aの時に0を返す．
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b|
      b.favorites.where(created_at: from...to).size <=>
      a.favorites.where(created_at: from...to).size
    }
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    # if ViewCount.find_by(user_id: current_user.id, book_id: @book.id).nil?
      view_count = current_user.view_counts.create(book_id: @book.id)
      view_count.save
    # end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
