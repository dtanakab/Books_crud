class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
