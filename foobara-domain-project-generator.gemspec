# frozen_string_literal: true

require_relative "lib/foobara/domain_project_generator/version"

Gem::Specification.new do |spec|
  spec.name = "foobara-domain-project-generator"
  spec.version = Foobara::DomainProjectGenerator::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Generates domain project boilerplate code from a template"
  spec.homepage = "https://github.com/foobara/domain-project-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE.txt"
  ]

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
