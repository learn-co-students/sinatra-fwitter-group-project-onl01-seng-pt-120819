class TweetsController < ApplicationController

    get '/tweets' do 
        if Helpers.logged_in?(session)
            @tweets = Tweet.all
            erb :'tweets/index'
        else 
            redirect to '/login'
        end 
    end

    get '/tweets/new' do 
        if Helpers.logged_in?(session)
            erb :'tweets/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/tweets' do 
        if params[:content] == ""
            redirect to '/tweets/new'
        else 
            tweet = Tweet.new(params)
            user = Helpers.current_user(session)
            tweet.user = user
            tweet.save
            redirect to '/tweets'
        end 
    end 

    get '/tweets/:id' do 
        # binding.pry
        if !Helpers.logged_in?(session)
            redirect to '/login'
        end 
        @tweet = Tweet.find_by(id: params[:id])
        if !@tweet 
            redirect to '/tweets'
        end 

        erb :'tweets/show'
    end 

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by(id: params[:id])
        if !Helpers.logged_in?(session)
            redirect to '/login'
        elsif !@tweet || @tweet.user != Helpers.current_user(session)
            redirect to '/tweets'
        end 
        erb :'/tweets/edit'
    end 

    patch '/tweets/:id' do 
        tweet = Tweet.find_by(id: params[:id])
        if tweet && params[:content] != "" && tweet.user == Helpers.current_user(session) 
            tweet.update(content: params[:content])
            redirect to "/tweets/#{tweet.id}"
        else 
            redirect to "/tweets/#{tweet.id}/edit"
        end 
    end 

    delete '/tweets/:id/delete' do 
        tweet = Tweet.find_by(id: params[:id])
        if tweet && tweet.user == Helpers.current_user(session) 
            tweet.destroy
        end 
        redirect to '/tweets'
    end 

end
