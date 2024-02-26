source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

# TODO: move this to .gemspec
gem "foobara", git: "foobara", branch: "main"

# gem "foobara-dotenv-loader", github: "foobara/dotenv-loader"
# gem "foobara-dotenv-loader", path: "../dotenv-loader"
# gem "foobara-rack-connector", github: "rack-connector", branch: "main"
# gem "foobara-rack-connector", path: "..-connector", branch: "main"
# gem "foobara-redis-crud-driver", github: "foobara/redis-crud-driver"
# gem "foobara-redis-crud-driver", path: "../redis-crud-driver"
# gem "foobara-resque-connector", github: "foobara/resque-connector"
# gem "foobara-resque-connector", path: "../resque-connector"
# gem "foobara-resque-scheduler-connector", github: "foobara/resque-scheduler-connector"
# gem "foobara-resque-scheduler-connector", path: "../resque-scheduler-connector"
# gem "foobara-sh-cli-connector", github: "foobara/sh-cli-connector"
# gem "foobara-sh-cli-connector", path: "../sh-cli-connector"
gem "foobara-util", github: "foobara/util"
# gem "foobara-util", path: "../util"

gem "rake"

group :development do
  gem "foobara-rubocop-rules", github: "foobara/rubocop-rules"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "foobara-spec-helpers", github: "foobara/spec-helpers"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
end
