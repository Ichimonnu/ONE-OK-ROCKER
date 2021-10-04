class PostsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

    def index
        if params[:search] == nil
            #@posts= Post.all.page(params[:page]).per(3)
            @posts= Post.all.page(params[:page]).per(3).order("id DESC")
        elsif params[:search] == ''
            @posts= Post.all.page(params[:page]).per(3).order("id DESC")
        else
            #部分検索
            @posts = Post.where("title LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(3).order("id DESC")
            
        end
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
    
    end

    def bukken
        @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.page(params[:page]).per(3).order("id DESC") : Post.all.page(params[:page]).per(3).order("id DESC")
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
    end

    def link
    end

    def new
        @post = Post.new
    end
    
    def create
        post = Post.new(post_params)
        # 動画投稿
        url = params[:post][:youtube_url]
        url = url.last(11)
        post.youtube_url = url
        post.user_id = current_user.id
        if post.save
        redirect_to :action => "index"
        else
        redirect_to :action => "new"
        end
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
        redirect_to :action => "show", :id => post.id
        else
        redirect_to :action => "new"
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
    end
    
    private
    def post_params
        params.require(:post).permit(:title,:content,:lyric,:genre,:youtube_url,tag_ids: [])
    end

end