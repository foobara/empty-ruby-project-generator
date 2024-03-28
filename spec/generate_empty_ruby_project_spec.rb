RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::GenerateEmptyRubyProject do
  let(:name) { "name-space1_name-space1/name-space3_name-space4" }
  let(:author_names) { %w[Foo Bar] }
  let(:author_emails) { ["a@b.com", "c@d.com"] }

  let(:inputs) do
    {
      name:,
      author_names:,
      author_emails:
    }
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates an empty ruby project" do
    expect(outcome).to be_success

    expect(result["spec/spec_helper.rb"]).to include('require_relative "../boot/finish"')
  end

  context "with all options" do
    let(:homepage_url) { "https://example.com" }
    let(:license) { "LGPL" }

    let(:inputs) do
      {
        name:,
        description: "whatever",
        homepage_url:,
        author_names:,
        author_emails:,
        license:
      }
    end

    it "generates an empty ruby project using the given options" do
      expect(outcome).to be_success

      expect(result["spec/spec_helper.rb"]).to include('require_relative "../boot/finish"')
    end
  end
end
