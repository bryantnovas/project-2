require "sinatra/base"
require "sinatra/reloader"
require "pg"
require "pry"
require "redcarpet/compat"
require "rest-client"
require_relative "./forum"
run App::Server 