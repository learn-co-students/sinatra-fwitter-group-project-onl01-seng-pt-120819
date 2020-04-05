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
        @user= User.create(params)
            session[:user_id] = @user.id
            redirect to "/tweets"
        end 
    end
    
    get '/login' do 
        # binding.pry
        if is_logged_in?
            redirect to '/tweets'
        else
          erb :"users/login"
        end
    end 

    post '/login' do 
       @user = User.find_by(:username => params["username"])
        #   binding.pry
       if @user 
            session[:user_id] = @user.id 
            redirect to "/tweets"
           end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if !@user.nil?
          erb :'/users/show'
        else 
          redirect to '/login'
        end
      end      

    get '/logout' do 
        if is_logged_in?
            session.clear
            redirect to "/login"
        else 
            redirect to '/'
        end
    end 

    # post '/logout' do 
    #     if is_logged_in?
    #         session.clear
    #         redirect to "/login"
    #     else 
    #         redirect to '/login'
    #     end 
    # end

end
