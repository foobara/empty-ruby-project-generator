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
  let(:output_directory) { "#{__dir__}/../../empty_ruby_project_test_suite_project_output" }

  before do
    allow(command).to receive(:push_to_github).and_return(nil)
    FileUtils.rm_rf output_directory
  end

  it "contains base files" do
    expect(outcome).to be_success

    expect(result.keys).to include(".github/workflows/ci.yml")
    expect(result.keys).to include("lib/some_namespace/some_other_namespace/final_thingy.rb")
    expect(File).to exist("#{output_directory}/foobara-generated.json")
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
