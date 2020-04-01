class TweetsController < ApplicationController
    
    get '/tweets' do #R - Index Action 
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            @current_user = Helpers.current_user(session)
            erb :'tweets/tweets'
        else
            redirect to '/login' 
        end
    end

    get '/tweets/new' do #New Action 
        if Helpers.is_logged_in?(session)
            erb :'tweets/new' #create_tweet
        else 
            redirect '/login'
        end
    end

    post '/tweets' do #Create Action -- process/submit the create tweet form submission (tweet is created and saved to the DB)
        if params[:content] == ''      
            redirect to "/tweets/new"
        else
            @current_user = Helpers.current_user(session)
            @tweet = @current_user.tweets.create(:content => params[:content])
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id' do #Show Action 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do #Edit Action 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @current_user = Helpers.current_user(session)
            if @tweet.user == @current_user
                erb :'tweets/edit_tweet'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end  
    end

    patch '/tweets/:id' do #Update Action 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.content = params[:content]
            if @tweet.content == ''
                redirect to "/tweets/#{@tweet.id}/edit"  
            else 
                @tweet.save
                redirect to "/tweets/#{@tweet.id}" 
            end
        end  
    end 

    delete '/tweets/:id' do #Delete Action
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @current_user = Helpers.current_user(session)
            if @tweet.user == @current_user
                @tweet.delete 
            end
        else
            redirect to '/'
        end
    end
end
