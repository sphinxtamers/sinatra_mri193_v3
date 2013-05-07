require 'bundler'

Bundler.require :default, :development

ActiveRecord::Base.establish_connection ENV['DATABASE_URL']

class MyApp < Sinatra::Base
  #
end