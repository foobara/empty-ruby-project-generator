RSpec.describe Foobara::Generators::EmptyRubyProjectGenerator::GenerateEmptyRubyProject do
  let(:name) { "name-space1_name-space1/name-space3_name-space4" }
  let(:author_names) { ["Foo", "Bar"] }
  let(:author_emails) { ["a@b.com", "c@d.com"] }
  let(:license) { nil }

  let(:inputs) do
    {
      name:,
      author_names:,
      author_emails:,
      license:
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
    let(:license) { "MIT" }

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

  context "with Apache-2.0 license" do
    let(:license) { "Apache-2.0" }

    it "generates an empty ruby project with an Apache-2.0 license" do
      expect(outcome).to be_success

      expect(result.keys.grep(/LICENSE/)).to contain_exactly("LICENSE.txt", "LICENSE-APACHE-2.0.txt")
    end
  end

  context "with MPL-2.0 license" do
    let(:license) { "MPL-2.0" }

    it "generates an empty ruby project with an MPL-2.0 license" do
      expect(outcome).to be_success

      expect(result.keys.grep(/LICENSE/)).to contain_exactly("LICENSE.txt", "LICENSE-MPL-2.0.txt")
    end
  end

  context "with Apache-2.0 OR MIT license" do
    let(:license) { "Apache-2.0 OR MIT" }

    it "generates an empty ruby project with an Apache-2.0 OR MIT license" do
      expect(outcome).to be_success

      expect(result.keys.grep(/LICENSE/)).to contain_exactly("LICENSE.txt", "LICENSE-APACHE-2.0.txt", "LICENSE-MIT.txt")
    end
  end
end
