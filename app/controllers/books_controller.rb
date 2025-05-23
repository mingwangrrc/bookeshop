class BooksController < ApplicationController
  before_action :set_book, only: %i[show]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def news
    date = Date.today
    start_date = (date - 3).beginning_of_day
    @q = Book.where("created_at > ?", start_date).ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def recents
    date = Date.today
    start_date = (date - 3).beginning_of_day
    @q = Book.where("updated_at > ?", start_date).ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    # params.require(:book).permit(:title, :description, :author_ids => [], :genre_ids => [])
    params.require(:book).permit(:title, :description, images: [])
  end
end