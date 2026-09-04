ENV["FOOBARA_ENV"] ||= "development"

require "bundler/setup"

if ["development", "test"].include?(ENV["FOOBARA_ENV"])
  # simplecov:disable
  if ENV["CI"] != "true"
    if ENV["RUBY_DEBUG"] == "true"
      require "debug"
    elsif ENV["USE_PRY"] == "true"
      require "pry"
    elsif ENV["USE_PRY_BYEBUG"] == "true"
      require "pry"
      require "pry-byebug"
    end
  end
  # simplecov:enable
end

require_relative "config"
