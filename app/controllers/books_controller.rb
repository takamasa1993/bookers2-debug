class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless current_user.id == @book.user_id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      flash[:error] = "error to update the book."
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if current_user == @book.user
      @book.destroy
      flash[:success] = "Book was successfully deleted."
      redirect_to books_path
    else
      flash[:alert] = "Failed to delete the book."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
