class TweetsController < ApplicationController
 
    get '/tweets' do 
        @tweets = Tweet.all
        erb :'/tweets/index'
        redirect to '/login'
    end

    get '/tweets/new' do 
        erb :'/tweets/new'
    end

    post '/tweets' do 
        @tweet = Tweet.create(content: params[:content])
     redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
    end

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end

    post '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
    redirect to "/tweets/#{@tweet.id}"
    end

    delete 'tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        erb :'/tweets/show'
    end

 end
