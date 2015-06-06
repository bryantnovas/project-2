require "sinatra/base"
require "sinatra/reloader"
require "pg"
require "pry"
require "redcarpet"
require "rest-client"
require_relative "./forum"
run App::Server 