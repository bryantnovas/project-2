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
			@posts = params['topic']
			erb :posts
		end
	end #class
end # module