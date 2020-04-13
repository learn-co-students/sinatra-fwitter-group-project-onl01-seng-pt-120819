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
        if logged_in?(session)
            erb :'/tweets/new'
        else 
            redirect to '/login'
        end
    end

    post '/tweets' do  
        if logged_in?(session) 
            if params["content"] == "" 
                redirect to '/tweets/new'
            else
                @tweet = Tweet.new(content: params["content"])
                @tweet.user_id = current_user(session).id 
                @tweet.save 
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do 
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params["id"])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params["id"])
            if @tweet && @tweet.user == current_user(session)
                erb :'/tweets/edit'
            end 
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params["id"])
        if params["content"] != "" && @tweet.user_id == current_user(session).id
            @tweet.content = params["content"]
            @tweet.save 
            redirect to "/tweets/#{@tweet.id}"
        else 
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do 
        @tweet = Tweet.find_by_id(params["id"])
        if logged_in?(session) && @tweet.user_id == current_user(session).id
            @tweet.destroy 
        end
    end
end
