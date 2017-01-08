
require 'sinatra'
require 'sinatra/activerecord'
require './models'


# flash stuff
require 'bundler/setup'
require 'sinatra/flash'
enable :sessions

set :database, "sqlite3:sinatra_ar_exercise.sqlite3"

set :sessions, true

###########Associate the files #############################################################
class Post
    belongs_to  :user
end

class User
  has_many :posts
end

class Post
    belongs_to  :profile
end

class Profile
  has_many :posts
end


  ###########ROUTES#############################################################

get '/' do
"HALLO"
end

get '/homepage' do
  if current_user
    puts "CURRENT USER"
    flash[:notice] = "Welcome, #{@current_user.fname}."
  else
    puts "SUCCESS"
  end
  erb :homepage
end



get '/other_profiles' do
  puts params
  erb :other_profiles
end


post '/other_profiles' do
  puts  "other posts"
  puts params.inspect
  @user = User.where(username: params[:username]).first
  puts @user_posts
  @user_posts = @user.posts
  puts @user_posts.inspect
  # if User[:profile_id]
  #   @post = Post.find(User[:post_id])
  #   puts @post



  # @user = User.where(username: params[:username]).first
  # @post_id = @user_id
  # @user_posts = User.find(session[:user_id]).posts
  # puts @user_posts.inspect

  # redirect to ("/other_profiles?key=#@username")

  erb :other_profiles
end


get '/sign-up' do
  erb :sign_up_form
end

post '/sign-up' do
  puts params.inspect
  @user = User.create(params)
end

get '/sign-in' do
  erb :sign_in_form
end

post '/sign-in' do
  puts params.inspect
  @user = User.where(username: params[:username]).first
  puts @user

    if @user.password == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Success! you signed-in!"
      if current_user
        redirect '/sign-in'
        flash[:notice] =  "Welcome, #{@user.fname}."
      end
    else
      flash[:notice] = "FAIL"
      redirect '/sign-in'
    end
    @profile =Profile.create(username: params[:username], user_id: session[:user_id])
    puts @profile
        session[:profile_id] = @profile.id


end


get '/profile' do
  puts params.inspect
  @user = User.find(session[:user_id])
  puts @user
  @user_posts = User.find(session[:user_id]).posts
  puts @user_posts.inspect
  if session[:post_id]
    @post = Post.find(session[:post_id])
    puts @post
  end


  erb :profile
end

post '/profile/new' do
  puts params.inspect
  @post = Post.new(text: params[:text], user_id: session[:user_id], profile_id: session[:profile_id])
  # puts @post
  @current_user = User.find(session[:user_id])
  @post.user = @current_user
  @post.save

  # puts @user["username"]
  session[:post_id] = @post.id
  redirect '/profile'
end

post '/profile/edit' do
  puts params
  @user = User.find(session[:user_id])
  params.each do |key,value|
    if value != ''
          @user.update(key => value)
    end
  end

  redirect '/profile'
end

get '/profile/delete' do
  puts params
  @user = User.find(session[:user_id])
  @user.destroy
  redirect '/logout'
end


get '/logout' do
  session.clear
  "log out "
end


def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    puts @current_user
  end
end
