RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::Generators::InitialModuleGenerator do
  let(:project_config) do
    Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(name: "some-org/some-project")
  end

  let(:generator) do
    described_class.new(project_config)
  end

  describe "#module_path" do
    subject { generator.module_path }

    it { is_expected.to eq(["SomeOrg", "SomeProject"]) }
  end
end
