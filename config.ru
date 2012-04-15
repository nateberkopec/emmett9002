require File.expand_path(File.join(*%w[ initializer ]), File.dirname(__FILE__))

require './server'

run Sinatra::Application