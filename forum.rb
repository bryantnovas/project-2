require "pg"
module App
	class Server < Sinatra::Base
		$db = PG.connect({dbname: "forum_db"})
		configure do 
			register Sinatra::Reloader
			enable :sessions
		end	
		get '/' do
			erb :welcome
		end
		post '/posts' do 
			topic = params['topic']
			query = "INSERT INTO posts (topic) VALUES ($1)"
			$db.exec_params(query, [topic])
			# put data in the database]
			name = params['name']
			query1 = "INSERT INTO users (name) VALUES ($1)"
			$db.exec_params(query1, [name])
			redirect '/posts'
		end
		get '/posts' do
			query = "SELECT *,users.name FROM posts JOIN users ON posts.id = users.id "
			@posts = $db.exec(query)
			erb :posts
			# get all the posts from the database
			# render the posts
		end
	end #class
end # module