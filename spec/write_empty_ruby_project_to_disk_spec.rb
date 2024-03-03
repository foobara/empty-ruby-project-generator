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
      project_name:,
      description: "whatever",
      author_names: ["Somebody"],
      author_emails: ["some@email.com"],
      organization_name:
    )
  end

  let(:project_name) { "SomeNamespace::SomeOtherNamespace::FinalThingy" }
  let(:organization_name) { nil }
  let(:output_directory) { "#{__dir__}/../../empty_ruby_project_test_suite_project_output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(described_class).to receive(:git_commit).and_return(nil)
    # rubocop:enable RSpec/AnyInstance
    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(result.keys).to include(".github/workflows/ci.yml")
      expect(result.keys).to include("lib/some_namespace/some_other_namespace/final_thingy.rb")
      expect(File).to exist("#{output_directory}/foobara-generated.json")
    end

    context "with no #organization_name" do
      let(:organization_name) { "" }

      it "builds a project without an organization name" do
        expect(outcome).to be_success

        expect(result.keys).to include(".github/workflows/ci.yml")
        expect(result.keys).to include("lib/some_namespace/some_other_namespace/final_thingy.rb")
        expect(File).to exist("#{output_directory}/foobara-generated.json")
      end
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          project_config:
        }
      end

      it "constructs a default output directory from the project name" do
        command.cast_and_validate_inputs
        expect(command.output_directory).to eq("some-namespace/some-other-namespace-final-thingy")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
