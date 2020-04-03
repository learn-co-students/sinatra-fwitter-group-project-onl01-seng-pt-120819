require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    @user = current_user if logged_in?
    erb :'/users/home'
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
