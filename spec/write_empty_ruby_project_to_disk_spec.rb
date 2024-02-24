RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::WriteEmptyRubyProjectToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      project_config:,
      output_directory:
    }
  end
  let(:project_config) do
    Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(full_project_name:, description: "whatever")
  end

  let(:full_project_name) { "SomeNamespace::SomeOtherNamespace::FinalThingy" }
  let(:output_directory) { "#{__dir__}/../tmp/test_project_output" }

  it "contains base files" do
    expect(outcome).to be_success

    expect(result.keys).to include(".github/workflows/ci.yml")
    expect(result.keys).to include("lib/some_namespace/some_other_namespace/final_thingy.rb")
    expect(File).to exist("#{output_directory}/foobara-generated.json")
  end
end
