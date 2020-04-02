class TweetsController < ApplicationController

    get '/tweets' do 
    #    @user = User.find_by(id: params[:id])
        # binding.pry
       if !is_logged_in?
            redirect to "/login"
        else
       erb :"tweets/index"    #loads the tweet index after login
        end 
    end 

    post '/tweets' do
        if !is_logged_in?
            redirect to "/login"
        else
            erb :tweets
        end
    end 
end
