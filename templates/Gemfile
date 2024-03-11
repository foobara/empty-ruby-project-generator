source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

# TODO: move this to .gemspec
gem "foobara", git: "foobara", branch: "main"

gem "foobara-dotenv-loader", github: "foobara/dotenv-loader"
gem "foobara-util", github: "foobara/util"

gem "rake"

group :development do
  gem "foobara-command-generator", github: "foobara/command-generator"
  gem "foobara-domain-generator", github: "foobara/domain-generator"
  gem "foobara-empty-ruby-project-generator", github: "foobara/empty-ruby-project-generator"
  gem "foobara-files-generator", github: "foobara/files-generator"
  # TODO: only need this one once everything is published gems and we can use .gemspec for this
  gem "foobara-foob", github: "foobara/foob"
  gem "foobara-organization-generator", github: "foobara/organization-generator"
  gem "foobara-rubocop-rules", github: "foobara/rubocop-rules"
  gem "foobara-sh-cli-connector", github: "foobara/sh-cli-connector"
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
  gem "ruby-prof"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end
