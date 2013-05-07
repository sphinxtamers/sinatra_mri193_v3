require 'bundler'

Bundler.require :default, :development

require 'flying_sphinx/tasks'

task :environment do
  ActiveRecord::Base.establish_connection ENV['DATABASE_URL']

  require './app/models/article'
end

namespace :db do
  namespace :schema do
    task :load => :environment do
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

    Rake::Task['fs:index'].invoke
    Rake::Task['fs:start'].invoke
  end

  task :test => :environment do
    article = Article.find_by_title!('Rails Ruby Sphinx')

    puts "Checking search count"
    raise "Search count failed" if Article.search.length != 1
    puts "Checking search match"
    raise "Search match failed"  if Article.search('lorem').first != article

    Rake::Task['fs:rebuild'].invoke

    sleep 2

    puts "Checking search count"
    raise "Search count failed" if Article.search.length != 1
    puts "Checking search match"
    raise "Search match failed"  if Article.search('lorem').first != article
  end

  task :cleanup => 'fs:stop'
end
