ENV["FOOBARA_ENV"] = "test"

require "bundler/setup"

require "pry"
require "pry-byebug"
require "rspec/its"

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.order = :defined
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.raise_errors_for_deprecations!
end

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

require "foobara/spec_helpers/all"
require "foobara/empty_ruby_project_generator"
