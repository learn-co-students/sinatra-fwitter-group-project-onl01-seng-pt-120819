class UsersController < ApplicationController

    

    get '/signup' do 
        if logged_in?
            redirect to '/tweets'
        end
        erb :'/users/signup'
    end
    

    post '/signup' do 
        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        if user.valid?
        session[:user_id] = user.id  
        redirect to '/tweets'
        else 
        redirect to "/signup"
    end
  end 


    get '/login' do 
        if logged_in? 
            redirect to '/tweets'
        end
        erb :'/users/login'
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect to '/tweets'
        else
            redirect to '/signup'
        end 
    end
    
    
    get '/logout' do 
        session.clear 
    redirect to "/login"
    end

    helpers do 
        def logged_in?
            !!session[:user_id]
        end

        def current_user
          @user = User.find(session[:user_id])
        end
    
    end

end
