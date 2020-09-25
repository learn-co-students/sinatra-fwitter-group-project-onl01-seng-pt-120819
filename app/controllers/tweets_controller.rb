class TweetsController < ApplicationController

  get '/tweets' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweets = Tweet.all
        @user = Helpers.current_user(session)
        erb :"/tweets/tweets"
    end

    get '/tweets/new' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        erb :"/tweets/new"
    end

    post '/tweets' do
        user = Helpers.current_user(session)
        if params["content"].empty?
            flash[:empty_tweet] = "Please enter content for your tweet"
            redirect to '/tweets/new'
        end
        tweet = Tweet.create(:content => params["content"], :user_id => user.id)
        redirect to '/tweets'
    end

    get '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find_by(id: params[:id])
        erb :'tweets/show_tweets'
    end

    get '/tweets/:id/edit' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find_by(id: params[:id])
        if Helpers.current_user(session).id != @tweet.user_id
            flash[:wrong_user_edit] = "Sorry, you can only edit your own tweets"
            redirect to '/tweets'

        end
        erb :'tweets/edit_tweets'
    end

    patch '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        tweet = Tweet.find_by(id: params[:id])

        if params["content"].empty?
            flash[:empty_tweet] = "Please enter content for your tweet"

            redirect to "/tweets/#{tweet.id}/edit"
        end
        tweet.update(:content => params["content"])

        redirect to "/tweets/#{tweet.id}"
    end

    delete '/tweets/:id/delete' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        tweet = Tweet.find_by(id: params[:id])
        if tweet && tweet.user == Helpers.current_user(session)
          tweet.destroy
          # Helpers.current_user(session).id != @tweet.user_id
          #   flash[:wrong_user_edit] = "Sorry, you can only edit your own tweets"
            redirect to '/tweets'
        end
        # @tweet.delete
        # redirect '/tweets'
    end

end
