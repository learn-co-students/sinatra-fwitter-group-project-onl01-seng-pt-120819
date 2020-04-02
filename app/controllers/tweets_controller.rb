require 'pry'
class TweetsController < ApplicationController



    get '/tweets' do 
        # binding.pry
        if logged_in?
            @tweets = Tweet.all 
            # binding.pry
            erb :'/tweets/index'
        else
            redirect to '/login'
        end
    end
   # get '/tweets/index' do

  #   erb :layout
  # end
#   gets tweet new 

end
