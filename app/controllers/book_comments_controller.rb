class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      flash[:notice] = "You have created comment successfully."
      @book_new = Book.new
      @book_comments = @book.book_comments
      @book_comment = BookComment.new
    else
      @book_new = Book.new
      @book_comments = @book.book_comments
      @book_comment = BookComment.new
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user_id != current_user.id
      redirect_to book_path(@book_comment.book_id)
    else
      @book_comment.destroy
      @book_new = Book.new
      @book_comments = @book.book_comments
      @book_comment = BookComment.new
    end
  end
  
  private 
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
