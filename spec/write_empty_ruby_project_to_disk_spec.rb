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
      name:,
      description: "whatever",
      author_names: ["Somebody"],
      author_emails: ["some@email.com"],
      use_git: true,
      push_to_github: true,
      turn_on_rbenv_bundler: true
    )
  end
  let(:name) { "some-org/some-namespace_some-other-namespace_final-thingy" }
  let(:output_directory) { "#{__dir__}/../tmp/empty_ruby_project_test_suite_project_output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    # Stubbing these to let more lines of the code be hit by the test suite
    allow_any_instance_of(described_class).to receive(:push_to_github_failed).and_return(nil)
    allow_any_instance_of(described_class).to receive(:use_git_failed).and_return(nil)
    # rubocop:enable RSpec/AnyInstance
    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(command.paths_to_source_code.keys).to include(".github/workflows/ci.yml")
      expect(command.paths_to_source_code.keys).to include(
        "lib/some_org/some_namespace_some_other_namespace_final_thingy.rb"
      )
    end

    context "with no #organization_name" do
      let(:name) { "some-namespace_some-other-namespace_final-thingy" }
      let(:project_config) do
        Foobara::Generators::EmptyRubyProjectGenerator::ProjectConfig.new(
          name:,
          description: "whatever",
          author_names: ["Somebody"],
          author_emails: ["some@email.com"]
        )
      end

      it "builds a project without an organization name" do
        expect(outcome).to be_success

        expect(command.paths_to_source_code.keys).to include(".github/workflows/ci.yml")
        expect(command.paths_to_source_code.keys).to include("lib/some_namespace_some_other_namespace_final_thingy.rb")
      end
    end

    context "with ExtractRepo support" do
      let(:repo_path) do
        "#{__dir__}/fixtures/test_repo"
      end
      let(:inputs) do
        {
          project_config:,
          output_directory:,
          extract_from_repo: repo_path,
          delete_extracted:,
          paths_to_extract:
        }
      end
      let(:delete_extracted) { true }
      let(:paths_to_extract) { %w[new_name] }

      def inflate_test_repo
        Dir.chdir(File.dirname(repo_path)) do
          # :nocov:
          unless Dir.exist?("extract_repo")
            `tar zxvf test_repo.tar.gz`
            unless $CHILD_STATUS.exitstatus == 0
              raise "Failed to inflate test repo"
            end
          end
          # :nocov:
        end
      end

      def rm_test_repo
        Dir.chdir(File.dirname(repo_path)) do
          # :nocov:
          if Dir.exist?("extract_repo")
            `rm -rf extract_repo`
            unless $CHILD_STATUS.exitstatus == 0
              raise "Failed to remove test repo"
            end
          end
          # :nocov:
        end
      end

      before do
        inflate_test_repo
        rm_test_repo
      end

      it "generates a new repo with a new project plus the extracted files" do
        expect(outcome).to be_success

        expect(command.paths_to_source_code.keys).to include(".github/workflows/ci.yml")
        expect(command.paths_to_source_code.keys).to include(
          "lib/some_org/some_namespace_some_other_namespace_final_thingy.rb"
        )
        Dir.chdir output_directory do
          expect(File).to exist("new_name/new_name.txt")
        end
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
        expect(command.output_directory).to eq("some-org/some-namespace-some-other-namespace-final-thingy")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
