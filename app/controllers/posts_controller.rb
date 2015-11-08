class PostsController < ApplicationController
  before_filter :authorize, except: [:show]

  def index
    @post = Post.new
    @posts = Post.includes(:user).order('posts.created_at desc').paginate(page: params[:page], per_page: 5)

    current_user.posts.each do |post|
      post.comments.update_all(read: true) if post.user == current_user
    end

    render partial: 'posts' if params[:page]
  end

  def show
    @posts = Post.includes(:user).where(id: params[:id]).all
  end

  def create
    post = current_user.posts.build(params[:post])
    post.save!
    redirect_to action: :index
    # else
    # redirect_to :action => :index
    # flash[:error] = "O campo  não pode ficar em branco"
    # end
  end

  def comment
    post = Post.find(params[:post_id])
    post.comments.create(comment: params[:comment], user: current_user)
    render nothing: true
  end

  def comments
    post = Post.find(params[:post_id])
    render partial: 'comments', locals: { post: post }
  end
end
