# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    redirect_to @comment.commentable, notice: t('messages.created') if @comment.save
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment.update(comment_params)
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t('messages.updated')
    end
  end

  def destroy
    comment_parent = @comment.commentable
    @comment.destroy
    redirect_to comment_parent, notice: t('messages.destroyed')
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end

  def identity_verification
    if @comment.user != current_user
      flash[:notice] = t('messages.userself_only')
      redirect_to @comment.commentable
    end
  end
end
