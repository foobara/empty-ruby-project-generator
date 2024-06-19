require_relative "version"
require "find"

Gem::Specification.new do |spec|
  spec.name = "foobara-empty-ruby-project-generator"
  spec.version = Foobara::EmptyRubyProjectGenerator::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Generates empty ruby project boilerplate code from a template"
  spec.homepage = "https://github.com/foobara/empty-ruby-project-generator"

  # Equivalent to SPDX License Expression: Apache-2.0 OR MIT
  spec.license = "Apache-2.0 OR MIT"
  spec.licenses = ["Apache-2.0", "MIT"]

  spec.required_ruby_version = ">= #{File.read("#{__dir__}/.ruby-version")}"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # TODO: why not "templates/**/*" ?
  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "templates/**/*",
    "LICENSE*.txt",
    "README.md",
    "CHANGELOG.md"
  ] + Find.find("templates/").select { |f| File.file?(f) }

  spec.add_dependency "foobara"
  spec.add_dependency "foobara-files-generator"

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
