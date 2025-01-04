require_relative "version"
require "find"

local_ruby_version = File.read("#{__dir__}/.ruby-version").chomp
local_ruby_version_minor = local_ruby_version[/\A(\d+\.\d+)\.\d+\z/, 1]
minimum_ruby_version = "#{local_ruby_version_minor}.0"

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

  spec.required_ruby_version = ">= #{minimum_ruby_version}"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE*.txt",
    "README.md",
    "CHANGELOG.md"
    # NOTE: We can't just do "templates/**/*" because there can be hidden files/directories which are skipped
  ] + Find.find("templates/").select { |f| File.file?(f) }

  spec.add_dependency "extract-repo"
  spec.add_dependency "foobara"
  spec.add_dependency "foobara-files-generator"

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
