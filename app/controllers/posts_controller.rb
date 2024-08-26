class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.includes(:user)
  end
end
