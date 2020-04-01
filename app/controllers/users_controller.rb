class UsersController < ApplicationController

    get '/signup' do 
        if is_logged_in?
            redirect to '/tweets'
        else 
        erb :"/users/create_user"
        end 
    end
  
    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
       else
        @user= User.create(:username => params["username"], :email => params["email"], :password => params["password"])
            @user.save
            session[:user_id] = @user.id
            redirect to "/tweets"
        end 
    end
    
    get '/login' do 
        # binding.pry
        # if is_logged_in?
            # redirect to '/tweets'
        #   end
        #   erb :'/users/login'
    end 

    post '/login' do 
       user = User.find_by(:username => params[:username])
       
            redirect to "/tweets"
    
    end
end
