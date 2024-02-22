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
    Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(
      domain_name: "SomeDomain",
      organization_name: "SomeOrg"
    )
  end
  let(:output_directory) { "#{__dir__}/../../tmp/domains" }

  it "contains base files" do
    expect(outcome).to be_success

    expect(result.keys).to include(".github/workflows/ci.yml")
    expect(File).to exist("#{output_directory}/foobara-generated.json")
  end
end
