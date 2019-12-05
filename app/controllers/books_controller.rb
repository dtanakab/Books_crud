# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: t("messages.created")
    else
      render :new
    end
  end

  def update
    @book.update(book_params)
    if @book.update(book_params)
      redirect_to @book, notice: t("messages.updated")
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: t("messages.destroyed")
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
