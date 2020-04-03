class TweetsController < ApplicationController
 
    get '/tweets' do 
       #binding.pry 
        if logged_in?
          @user = current_user
          @tweets = Tweet.all
          erb :'/tweets/index'
        else 
        redirect to "/login"
        #binding.pry
      end  
    end
    
    

    get '/tweets/new' do 
        if logged_in? 
          @user = current_user 
          erb :'/tweets/new'
        else 
        redirect to "/login"
      end
    end 

    post '/tweets' do 
        if !params[:content].empty?
          @tweet = Tweet.create(content: params[:content], user_id: current_user)
        redirect to "/tweets"
        else   
            flash[:empty_tweet] = "Please enter content for your tweet"
            redirect to "/tweets/new"
        end
    end

    get '/tweets/:id' do 
        if logged_in? 
          @user = current_user 
          @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
        else 
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do 
          @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == current_user 
        erb :'/tweets/show'
        else 
        redirect to "/login"
      end
    end

    post '/tweets/:id' do 
          @tweet = Tweet.find_by_id(params[:id])
        if !params[:content].empty?
          @tweet.update(content: params[:content])
          @tweet.save
        redirect to "/tweets/#{params[:id]}"
        else   
          redirect "tweets/#{params[:id]}/edit"
    
        end 
    end

    post 'tweets/:id/delete' do
          @tweet = Tweet.find_by_id(params[:id])
        if current_user == @tweet.user
          @tweet.delete
        redirect to "/tweets/show"
        else   
        redirect to "/tweets/#{params[:id]}"
        end      
    end

 end
