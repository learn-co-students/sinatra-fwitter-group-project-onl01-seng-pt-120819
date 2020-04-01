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
    erb :layout
  end

  helpers do
  
    def logged_in?
       
      if session[:user_id]
        true
      else 
        false
      end
    #  if the session hash has a user id that means someone is logged in 
end

    def current_user
      User.find(session[:user_id])
      # find current user based on current user id inside of the session
    end
  
  end



end
