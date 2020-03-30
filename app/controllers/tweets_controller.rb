class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?(session)
            @tweets = Tweet.all 
            erb :'/tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do 
        erb :'/tweets/new'
    end

    post '/tweets' do 
        redirect to '/tweets'
    end

    get '/tweets/:id' do 
        binding.pry 
        @user = User.find_by_id(session["user_id"])
        erb :'/tweets/show'
    end

end
