# Homepage (Root path)
require 'sinatra'
require 'sinatra/flash'

enable :sessions

helpers do
	def create_session(user)
		session["current_user"]= user.id
		session["username"] = user.username
	end
end

get '/' do
  erb :index
end

get '/songs' do
	@songs = Song.all
	erb :'songs/index'
end

get	'/songs/new_song' do
	@song = Song.new
	erb :'songs/new_song'
end

get	'/songs/:id' do
	@song = Song.find(params[:id])
	@user_id = @song.user_id
	@user = User.find(@user_id)
	@username = @user.username

	erb :'songs/show'
end

delete '/songs/:id' do
	@song = Song.find(params[:id])
	#figure out how to delete song
	@song.destroy
	redirect '/homepage'
	flash[:notice] = "Your song was deleted"
end

get '/login' do
	erb :'users/login'
end

get	'/sign_up' do
	@user = User.new
	erb :'users/sign_up'
end

get	'/homepage' do
	@user_id = session["current_user"]
	@user_songs = Song.where(user_id: @user_id)

	erb :'users/homepage'
end

post '/sign_up' do
	@user = User.new(
		username: params[:username],
		email: params[:email],
		password: params[:password] 
		)
	if @user.save
		create_session(@user)
		redirect '/homepage'
	else
		flash[:error] = @user.errors.full_messages
		erb :'users/sign_up'
	end
end

get '/logout' do
	session.clear
	redirect '/'
end

post '/login' do 
	@user = User.find_by(:email=>params[:email], :password=>params[:password])
	if @user
		create_session(@user)
		redirect '/homepage'
	else
		flash[:notice] = "Wrong email or password, try again..."
		erb :'users/login'
	end
end


#submiting new data to server, POST request to server
#telling sinatra to accept this action
post '/songs' do
	@user = User.find(session["current_user"])
	@song = Song.new(
		title: params[:title],
		author: params[:author],
		url: params[:url],
		user_id: @user.id
		)
	if @song.save
		redirect '/songs'
	else
		erb :'songs/new_song'
	end
end
