class TweetsController < ApplicationController

    get "/tweets" do 
      
        if !is_logged_in?
            redirect to "/login"
        else 
          @tweets = Tweet.all
          @user = current_user
           erb  :'/tweets/tweets'
        end
    end

   get '/tweets/new' do
    if !is_logged_in?
      redirect to '/login'
    end
    erb :'/tweets/new'
  end

  post '/tweets/new' do
    if !is_logged_in?
      redirect to '/login'
    end
    @user = current_user
    @tweet = Tweet.new(content: params["content"], user_id: @user.id)
    
    if @tweet.valid?
      @tweet.save
      redirect to '/tweets'
    else
      flash[:message] = "No Content"
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !is_logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"
  end

  get '/tweets/:id/edit' do
    
    if is_logged_in? 
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user == current_user
        erb :'/tweets/edit'
      else
        redirect to "/tweets"
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])

    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params["content"])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:id])
    if is_logged_in? && current_user
      
      
        @tweet.delete
        redirect to '/tweets'
      
    else
     erb :"/login"
    end
  end

end
