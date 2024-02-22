RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::GenerateEmptyRubyProject do
  let(:project_config) do
    Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(full_module_name, description: "whatever")
  end

  let(:full_module_name) { "Namespace1::Namespace1::Namespace3::Namespace4" }

  let(:inputs) do
    {
      project_config:
    }
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates an empty ruby project" do
    expect(outcome).to be_success

    expect(result["spec/spec_helper.rb"]).to include('require "namespace1/namespace1/namespace3/namespace4"')
  end

  context "with all options" do
    let(:homepage_url) { "https://example.com" }
    let(:author_names) { %w[Foo Bar] }
    let(:author_emails) { ["a@b.com", "c@d.com"] }
    let(:license) { "LGPL" }

    let(:project_config) do
      Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(
        full_module_name,
        description: "whatever",
        homepage_url:,
        author_names:,
        author_emails:,
        license:
      )
    end

    it "generates an empty ruby project using the given options" do
      expect(outcome).to be_success

      expect(result["spec/spec_helper.rb"]).to include('require "namespace1/namespace1/namespace3/namespace4"')
    end
  end
end
