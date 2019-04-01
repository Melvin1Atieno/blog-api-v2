# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_blog, only: [:create, :index, :update, :destroy]

  # GET /comments
  def index
    @comments = @blog.comments
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @blog.comments.create(comment_params)
    
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @blog.user != @current_user
      render json: @comment.errors, status: :unauthorized 
    elsif @comment.update(comment_params)
      render json: @comment, status: :success
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @blog.user != @current_user
      render json: @comment.errors, status: :unauthorized
    else
      @comment.destroy
      render json: {data: {type: 'comment', attributes: {comment: 'Deleted'}}}
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:data).permit(attributes:[:body])
    end
end
