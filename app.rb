
require 'sinatra'
require 'sinatra/activerecord'
require './models'

# flash stuff
require 'bundler/setup'
require 'sinatra/flash'
enable :sessions

set :database, "sqlite3:sinatra_ar_exercise.sqlite3"

set :sessions, true


get '/' do
"HALLO"
end

get '/homepage' do
  erb :homepage
  # if current_user
  #   puts "CURRENT USER"
  #   flash[:notice] = "Welcome, #{@current_user.fname}."
  # else
  #   puts "SUCCESS"
  # end
end

get '/sign-up' do
  erb :sign_up_form
end
post '/homepage' do
  puts params.inspect
  @user = User.create(params)
  redirect '/homepage'
end
get '/sign-in' do
  erb :sign_in_form
end

post '/profile' do
  erb :profile
  puts params.inspect
  @user = User.where(username: params[:username]).first
  puts @user

    if @user.password == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Success! you signed-in!"
      if current_user
        redirect '/profile'
        flash[:notice] =  "Welcome, #{@user.fname}."
      end
    else
      flash[:notice] = "FAIL"
    end
end


get '/profile' do
  erb :profile
  puts params.inspect
  @user = User.find(session[:user_id])
  puts @user
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    puts @current_user
  end
end
