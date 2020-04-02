class UsersController < ApplicationController
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/signup' do 
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end 

    post '/signup' do
        if params[:username] == '' || params[:email] == '' || params[:password] == ''
            redirect to '/signup'
        else
            user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        end
    end    

    get '/login' do
        if !Helpers.is_logged_in?(session)
            erb :'users/login' 
        else
             redirect to '/tweets'
        end
    end 
    
    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password]) 
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear 
            redirect '/login'
        else
            redirect '/tweets/tweets'
        end
    end

end

