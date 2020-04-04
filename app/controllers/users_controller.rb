class UsersController < ApplicationController

    

    get '/signup' do 
        if logged_in?
            redirect to "/tweets"
        else 
        erb :'/users/signup'
    end
end
    

    post '/signup' do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        #binding.pry
        session[:user_id] = user.id  
        redirect to "/tweets"
    end
    end 
 



    get '/login' do 
        if logged_in? 
            redirect to "/tweets"
        else  
        erb :'/users/login'
    end
   end 

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect to '/tweets'
        else
            flash[:login_error] = "Incorrect login. Please try again."
            redirect to '/login'
        end 
    end
     
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end  
    
    
    get '/logout' do 
        session.clear 
    redirect to "/login"
    end

    
end
