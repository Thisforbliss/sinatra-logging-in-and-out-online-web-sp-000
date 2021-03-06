require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
    
  end

  get '/' do
    erb :index
    #binding.pry
  end

  post '/login' do
    user = User.find_by(username: params["username"], password: params["password"])
      if user 
      session[:user_id] = user.id 
      redirect_to '/account'
      else
      erb :error
      end
  end

  get '/account' do
    erb :account
  end

  get '/logout' do
  session.clear
  redirect_to "/"
  end


end

