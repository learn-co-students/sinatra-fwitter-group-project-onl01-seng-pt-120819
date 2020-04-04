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
          erb :'/tweets/new'
        else 
        redirect to "/login"
      end
    end 

    post '/tweets' do 
        if logged_in? && !params[:content].empty?
            
          @tweet = current_user.tweets.build(content: params[:content])
          @tweet.save
          #binding.pry
            redirect to "/tweets/#{@tweet.id}"
          else 
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
        #binding.pry
          @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == current_user.id 
        erb :'/tweets/edit'
        else 
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do 
          @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && !params[:content].empty? 
          @tweet.update(content: params[:content])
          @tweet.save
        redirect to "/tweets/#{params[:id]}"
        else   
          redirect "tweets/#{params[:id]}/edit"
    
        end 
    end

    delete '/tweets/:id/delete' do
        # binding.pry
            @tweet = Tweet.find_by_id(params[:id])
            if logged_in? && @tweet.id == current_user.id  
              @tweet.delete
            redirect to "/tweets/index"
            else   
            redirect to "/login"
            end 
        #end     
        end
    
     end
