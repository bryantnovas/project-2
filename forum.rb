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
<<<<<<< HEAD
			@topics = params['topic']
			query = "INSERT INTO posts (topic) VALUES ($1)"
			$db.exec_params(query, [@topics])
			# put data in the database
			redirect '/posts'
		end
		get '/posts' do
			query = "SELECT * FROM posts "
			@posts = $db.exec(query)
			erb :posts
			# get all the posts from the database
			# render the posts
=======
			@posts = params['topic']
			erb :posts
>>>>>>> f6ee3b1423c7ffffd790ced407877f3c6ecd7db7
		end
	end #class
end # module