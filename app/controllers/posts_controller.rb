class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @q = Post.ransack(params[:q])
    today = Date.today

    if params[:status] == "ongoing"
      @posts = @q.result.where("start_date <= ? AND end_date >= ?", today, today).page(params[:page]).per(12)
    elsif params[:status] == "all"
      @posts = @q.result.distinct(true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)
    else
      @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), success: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      flash.now[:failure] = t("defaults.flash_message.not_created", item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: t("defaults.flash_message.updated", item: Post.model_name.human)
    else
      flash.now[:failure] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
  end

  def likes
    @like_posts = current_user.like_posts.includes(:user).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :event_url, :post_image, :post_image_cache, :start_date, :end_date, :prefecture_id)
  end
end
