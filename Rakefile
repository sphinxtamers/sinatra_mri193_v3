require 'bundler'

Bundler.require :default, :development

Sinatra::Application.environment = ENV['RACK_ENV'] || :development

config = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(
  config[Sinatra::Application.environment.to_s]
)

require 'app/models/article'

namespace :db do
  namespace :schema do
    task :load do
      load 'db/schema.rb'
    end
  end
end

namespace :trainer do
  task :prepare => :environment do
    Article.delete_all

    Article.create!(
      :title => 'Rails Ruby Sphinx',
      :body  => 'Lorem Ipsum and all that'
    )

    system 'flying-sphinx configure'
    system 'flying-sphinx index'
    system 'flying-sphinx start'
  end

  task :test => :environment do
    article = Article.find_by_title!('Rails Ruby Sphinx')

    puts "Checking search count"
    raise "Search count failed" if Article.search.length != 1
    puts "Checking search match"
    raise "Search match failed"  if Article.search('lorem').first != article

    system 'flying-sphinx rebuild'

    sleep 2

    puts "Checking search count"
    raise "Search count failed" if Article.search.length != 1
    puts "Checking search match"
    raise "Search match failed"  if Article.search('lorem').first != article
  end

  task :cleanup => :environment do
    system 'flying-sphinx stop'
  end
end
