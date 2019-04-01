# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    @blogs = Blog.all
    render json: @blogs
  end

  # GET /blogs/1
  def show
    render json: @blog
  end

  # POST /blogs
  def create
    @blog = @current_user.blogs.create(blog_params)

    if @blog.save
      render json: @blog, status: :created, location: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /blogs/1
  def update
    if @current_user != @blog.user
      render json: @blog.errors, status: :unauthorized
    elsif @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # # DELETE /blogs/1
  def destroy
    if current_user != @blog.user
      render json: @blog.errors, status: :unauthorized
    else
      @blog.destroy
      render json: {data:{type: 'blog', attributes:{blog: 'deleted'}}}
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

  #   # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:data).permit(attributes:[:title, :body])
    end
end
