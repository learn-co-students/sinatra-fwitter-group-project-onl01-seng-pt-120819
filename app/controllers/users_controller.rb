require 'pry'
class UsersController < ApplicationController


    get "/signup" do 
        if logged_in?
            redirect "/tweets"
        else 
        erb :'users/create_user'
      end
    end
    
    post "/signup" do
    #   binding.pry
      if  params[:username] == "" || params[:email] == "" || params[:password] == ""
           redirect to '/signup'
      else 
           user = User.new(:username=> params[:username], :email=> params[:email], :password=> params[:password])   
           user.save
           session[:user_id] = user.id
           redirect to "/tweets"

      end
    end


    get "/login" do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/tweets'
      end
    end

    post "/login" do 
        user = User.find_by(:username=> params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else 
            redirect to 'users/create_user'
        end
    end

    get '/logout' do 
      if logged_in?
          session.clear
          redirect to '/login'
      else 
          redirect to '/tweets'
      end 
  end 

  get "/users/:slug" do 
    # binding.pry
    @user = User.find_by_slug
    erb :'users/show'
  end
end
# gsub
# /songs/:slug