require 'pry'
class TweetsController < ApplicationController

 get '/tweets' do 
        # binding.pry
    if logged_in?
      @tweets = Tweet.all 
            # binding.pry
      erb :'/tweets/index'
    else
      redirect to '/login'
    end 
 end
   
 get '/tweets/new' do 
    if logged_in?
        erb :'/tweets/new'
    else 
        redirect to '/login'
    end
 end

 post '/tweets' do  
    if logged_in? 
        if params["content"] == "" 
            redirect to '/tweets/new'
        else
            # binding.pry
            @tweet = Tweet.new(content: params["content"])
            @tweet.user_id = current_user.id 
            @tweet.save 
            redirect to "/tweets/#{@tweet.id}"
        end
    else
        redirect to '/login'
    end
 end

 get '/tweets/:id' do 
    if logged_in?
        @tweet = Tweet.find_by_id(params["id"])
        erb :'/tweets/show'
    else
        redirect to '/login'
    end
 end

 get '/tweets/:id/edit' do 
    if logged_in?
        @tweet = Tweet.find_by_id(params["id"])
        if @tweet && @tweet.user == current_user
            erb :'/tweets/edit'
        end 
    else
        redirect to '/login'
    end
 end

 patch '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params["id"])
    if params["content"] != "" && @tweet.user_id == current_user.id
        @tweet.content = params["content"]
        @tweet.save 
        redirect to "/tweets/#{@tweet.id}"
    else 
        redirect to "/tweets/#{@tweet.id}/edit"
    end
 end

 delete '/tweets/:id/delete' do 
    @tweet = Tweet.find_by_id(params["id"])
    if logged_in? && @tweet.user_id == current_user.id
        @tweet.destroy
    end
 end
end
