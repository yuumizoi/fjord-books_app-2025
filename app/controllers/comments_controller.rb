# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: 'コメントを投稿しました。'
    else
      redirect_to @commentable, alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    redirect_to @commentable, notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    if params[:report_id]
      Report.find(params[:report_id])
    elsif params[:book_id]
      Book.find(params[:book_id])
    end
  end
end
