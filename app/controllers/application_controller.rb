require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  # get '/login' do
  #
  #   erb :account
  # end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user.nil?
      erb :error
    else
        session[:user_id] = @user.id
        redirect to '/account'
    end
  end

  get '/account' do
    @user = Helpers.current_user(session)
    erb :account
  end

  get '/logout' do
    if Helper.is_logged_in?
      erb :account
    else
      erb :index
    end

  end


end
