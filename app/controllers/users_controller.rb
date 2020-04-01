class UsersController < ApplicationController


    get "/signup" do 
        if logged_in?
            redirect "/tweets"
        else 
        erb :signup
      end
    end
    
    post "/signup" do
    #   binding.pry
      if  params[:username] == "" || params[:email] == "" || params[:password] == ""
           redirect "/signup"
      else 
           user = User.new(:username=> params[:username], :email=> params[:email], :password=> params[:password])   
           user.save
           session[:user_id] = user.id
           redirect "/tweets"

      end
    end


    get "/login" do
      if !logged_in?
    # logged_in? 
        erb :'users/login'
        #  redirect to '/tweets/index'
    #       redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    end






end
