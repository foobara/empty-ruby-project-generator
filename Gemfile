source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

# TODO: move this to .gemspec
gem "foobara", git: "foobara", branch: "main"
gem "foobara-files-generator", github: "foobara/files-generator"
# gem "foobara-files-generator", path: "../files-generator"
gem "foobara-util", github: "foobara/util"
# gem "foobara-util", path: "../util"

gem "rake"

group :development do
  gem "foobara-rubocop-rules", github: "foobara/rubocop-rules"
  gem "foobara-sh-cli-connector", github: "foobara/sh-cli-connector"
  # gem "foobara-sh-cli-connector", path: "../sh-cli-connector"
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
