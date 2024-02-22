RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::GenerateEmptyRubyProject do
  let(:project_config) do
    Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(full_module_name)
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
  end
end
