class TweetsController < ApplicationController

    get '/tweets' do 
       if is_logged_in?
         @tweets = Tweet.all
          erb :"tweets/index"  
        else
           redirect to "/login"
        end 
    end 

    post '/tweets' do
         @user = current_user
        #  binding.pry
    if params["content"].empty?
       redirect to '/tweets/new'
      end
      @tweets = Tweet.create(content: params[:content], user_id: @user.id)
    redirect to '/tweets'
      end
    
    get '/tweets/new' do
        if !is_logged_in?
            redirect to '/login'
       else
      erb :'tweets/tweets'
    end
    end 

    get '/tweets/:id' do 
        if !is_logged_in?
            redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
    #    binding.pry
        erb :"tweets/show_tweet"
    end 

    get '/tweets/:id/edit' do
        if !is_logged_in?
        redirect to '/login' 
        end
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == !current_user.id
            
            redirect to '/login'

        else
          erb :'/tweets/edit_tweet'
        end
      end

      patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
          redirect to "/tweets/#{@tweet.id}/edit"
        end
        @tweet.update(:content => params["content"])
        @tweet.save
    
        redirect to "/tweets/#{@tweet.id}"
      end
      
     post '/tweets/:id/delete' do
        if is_logged_in?
          @tweet = Tweet.find(params[:id])
          if @tweet.user == current_user
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.delete
            redirect to '/tweets'
          else
            redirect to '/tweets'
          end
        else
          redirect to '/login'
        end
      end
end
