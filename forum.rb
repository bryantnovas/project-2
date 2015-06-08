require "rest-client"
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
		post "/posts" do 
			topic = params['topic']
			query = "INSERT INTO posts (topic) VALUES ($1)"
			$db.exec_params(query, [topic])
			# put data in the database]
			name = params['name']
			result = JSON.parse(RestClient.get('http://ipinfo.io/json'))
			location = "#{result['city']} #{result['region']} #{result['country']}"
			query1 = "INSERT INTO users (name, location) VALUES ($1, $2)"
			$db.exec_params(query1, [name, location])
			redirect "/posts"
		end
		get '/posts' do
			query = "SELECT * FROM posts JOIN users ON posts.id = users.id ORDER BY votes DESC"
			@posts = $db.exec(query)
			erb :posts
			# get all the posts from the database
			# render the posts
		end
		get '/posts/:id' do
    	id = params['id']
			@post = $db.exec_params('SELECT * FROM posts WHERE id = $1',[id]).first
			@comments = $db.exec_params("SELECT * FROM comments WHERE post_id = $1",[id])
			erb :post
  	end

  	post '/posts/:id' do 
  		id = params['id']
  		query = "UPDATE posts SET votes = votes +1 WHERE id = $1"
  		$db.exec_params(query, [id])
  		redirect "/posts"
  	end

  	get '/comment/:id' do
  		@id = params['id'] 
  		erb :comment
  	end
  	post '/comment/:id' do
  		comment = params['comment']
  		id = params['id']
  		$db.exec_params("INSERT INTO comments (comment, post_id) VALUES ($1, $2)",[comment,id])
  		redirect "/posts/#{id}"
  	end
	end #class
end # module