source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

# TODO: move this to .gemspec
gem "foobara", git: "foobara", branch: "main"
gem "foobara-util", github: "foobara/util"
# If uncommenting the following for local development, you need to run: bundle config set local.foobara-util ../util
# gem "foobara-util", git: "foobara-util"

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
