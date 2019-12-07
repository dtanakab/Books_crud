# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :identity_verification, only: %i[update destroy]

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
    redirect_to current_user, notice: t("messages.destroyed")
  end

  def show
    @comments = @book.comments
    @comment = @book.comments.new
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end

    def identity_verification
      if @book.user != current_user
        flash[:notice] = t("messages.userself_only")
        redirect_to root_path
      end
    end
end
