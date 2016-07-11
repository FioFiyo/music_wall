# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
	@songs = Song.all
	erb :'songs/index'
end

get	'/songs/new_song' do
	erb :'songs/new_song'
end

#submiting new data to server, POST request to server
#telling sinatra to accept this action
post '/songs' do
	@song = Song.new(
		title: params[:title],
		author: params[:author],
		url: params[:url]
		)
	@song.save
	redirect '/songs/new_song'
end