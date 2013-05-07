require 'bundler'

Bundler.require :default, :development

Sinatra::Application.environment = ENV['RACK_ENV'] || :development

config = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(
  config[Sinatra::Application.environment.to_s]
)

class MyApp < Sinatra::Base
  #
end