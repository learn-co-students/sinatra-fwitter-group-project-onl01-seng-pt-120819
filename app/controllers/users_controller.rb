class UsersController < ApplicationController
  

    get "/signup" do 
         if is_logged_in?
            redirect to '/tweets'
         else
            erb :'users/signup'
         end
    end

   post "/signup" do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
            @user = User.create!(email: params[:email], username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            #binding.pry
            redirect to '/tweets'
        end
    end

    get '/login' do
       
       if is_logged_in?
            redirect to '/tweets'
        else 
        erb :'/users/login'
        end
    end

    post '/login' do
       @user = User.find_by(username: params[:username])
       #binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect  to '/tweets'
    else
      #flash[:login_error] = "Login Info Incorrect.  Please try again."
      redirect to '/login'
    end
    end

    get '/logout' do
        if is_logged_in?
        session.clear
        redirect to '/login'
        else
            redirect to '/'
        end
      end

      get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])

        erb :"users/show"
      end
end
