ENV["FOOBARA_ENV"] ||= "development"

require "bundler/setup"

if ENV["FOOBARA_ENV"] == "development" || ENV["FOOBARA_ENV"] == "test"
  require "pry"
  require "pry-byebug"
end

require_relative "config"
