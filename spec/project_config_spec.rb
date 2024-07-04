RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig do
  let(:project_config) do
    described_class.new(name: "some-org/some-project")
  end

  describe "#kebab_case_project_name" do
    subject { project_config.kebab_case_project_name }

    it { is_expected.to eq("some-project") }
  end
end
