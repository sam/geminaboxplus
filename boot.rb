require "rubygems"
require "bundler/setup"
require "resque"
require "reindexer"
require "resque/server"
require "redis_directory"
require "geminabox"

Resque::redis = Redis::Directory.new(:host => (ENV["REDIS_HOST"] || "localhost")).get("resque", "gems")
