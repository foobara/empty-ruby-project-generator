require_relative "src/version"
require "find"

Gem::Specification.new do |spec|
  spec.name = "foobara-empty-ruby-project-generator"
  spec.version = Foobara::EmptyRubyProjectGenerator::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Generates empty ruby project boilerplate code from a template"
  spec.homepage = "https://github.com/foobara/empty-ruby-project-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE.txt"
  ] + Find.find("templates/").select { |f| File.file?(f) }

  spec.add_dependency "foobara"

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
