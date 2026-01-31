class TweetsController < ApplicationController

     before_action :authenticate_user!, only: [:new, :create]

     def index
        @tweets = Tweet.all
         @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)

          if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|      
        @tweets += Tag.find_by(name: key).tweets if value == "1"
      end
      @tweets.uniq!
    end
     if params[:tag]
      Tag.create(name: params[:tag])
    end
    end

     def new
    @tweet = Tweet.new
  end 
  
  def create
    tweet = Tweet.new(tweet_params)

    tweet.user_id = current_user.id 
    
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new

  end

  def edit
  @tweet = Tweet.find(params[:id])
  end

def update
  @tweet = Tweet.find(params[:id])
  if @tweet.update(tweet_params)
    redirect_to tweet_path(@tweet)
  else
    render :edit
  end
end

def destroy
  @tweet = Tweet.find(params[:id])
  @tweet.destroy
  redirect_to tweets_path, notice: "投稿を削除しました"
end

   private
  def tweet_params
    params.require(:tweet).permit(:shop, :place, :purpose, :atomosphere, :detail, :image, :tag_ids)
  end

end
