require "sinatra/base"
require "sinatra/reloader"
require "pg"
require "pry"
require_relative "./forum"
run App::Server