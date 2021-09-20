class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
      post = Post.find(params[:post_id])
      comment = post.comments.build(comment_params) 
      comment.user_id = current_user.id
      if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end

    def destroy
      @post = Post.find(params[:post_id])
      comment = @post.comments.find(params[:id])
      comment.destroy
      redirect_to post_path(params[:post_id])
    end

    private
    def comment_params
        params.require(:comment).permit(:title,:content,:lyric,:user_id,:genre)
    end
end