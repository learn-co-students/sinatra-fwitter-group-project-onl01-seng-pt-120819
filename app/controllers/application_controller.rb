require './config/environment'
require'pry'
class ApplicationController < Sinatra::Base
  
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end
   
  get "/" do 
    erb :index
  end

  helpers do
    def logged_in?
     !!current_user
    #  if the session hash has a user id that means someone is logged in 
    end

    def current_user
      # binding.pry
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue ActiveRecord::RecordNotFound
      # find current user based on current user id inside of the session
    end
  end
end
