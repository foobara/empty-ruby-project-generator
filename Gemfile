source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

# gem "foobara-files-generator", path: "../files-generator"

gem "rake"

group :development do
  gem "foobara-rubocop-rules", ">= 1.0.0"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "foobara-spec-helpers", "~> 0.0.1"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
end
