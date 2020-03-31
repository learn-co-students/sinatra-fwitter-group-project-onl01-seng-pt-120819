class UsersController < ApplicationController

    get '/signup' do 
        if Helpers.logged_in?(session)
            user = Helpers.current_user(session)
            redirect to '/tweets'
        else 
            erb :'users/signup'
        end 
    end 

    get '/login' do 
        if Helpers.logged_in?(session)
            user = Helpers.current_user(session)
            redirect to '/tweets'
        else 
            erb :'users/login'
        end 
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

    post '/signup' do      
        user = User.new(params)
        user.save

        if user.valid? 
            session[:user_id] = user.id
            redirect to '/tweets'
        else 
            redirect to '/signup'
        end 
    end 

    get '/logout' do 
        if Helpers.logged_in?(session)
            session.clear
            redirect to '/login'
        else 
            redirect to '/'
        end 
    end 

    get '/users/:slug' do 
        slug = params[:slug]
        User.find_by_slug(slug)
        erb :'users/show'
    end 

end
