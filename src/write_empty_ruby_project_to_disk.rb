require_relative "generate_empty_ruby_project"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class WriteEmptyRubyProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "empty-ruby-project"
          end
        end

        inputs do
          project_config ProjectConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string, :required
        end

        depends_on GenerateEmptyRubyProject

        def execute
          generate_file_contents
          delete_old_files_if_needed
          write_all_files_to_disk
          run_post_generation_tasks

          paths_to_source_code
        end

        def generate_file_contents
          # TODO: just pass this in as the inputs instead of the command??
          self.paths_to_source_code = run_subcommand!(GenerateEmptyRubyProject, project_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            bundle_install
            make_bin_files_executable
            rubocop_autocorrect
            make_initial_git_commit
            git_add_remote_origin
            git_branch_main
            push_to_github
          end
        end

        def bundle_install
          Bundler.with_unbundled_env do
            Open3.popen3("bundle install") do |_stdin, _stdout, stderr, wait_thr|
              exit_status = wait_thr.value
              unless exit_status.success?
                # :nocov:
                raise "could not bundle install. #{stderr.read}"
                # :nocov:
              end
            end
          end
        end

        def rubocop_autocorrect
          Open3.popen3("bundle exec rubocop -A") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              # :nocov:
              raise "could not rubocop -A. #{stderr.read}"
              # :nocov:
            end
          end
        end

        def make_bin_files_executable
          Dir["bin/*"].each do |file|
            if File.file?(file)
              system("chmod u+x #{file}")
            end
          end
        end

        def make_initial_git_commit
          unless system("git init")
            raise "could not git init"
          end

          unless system("git add .")
            raise "could not git add ."
          end

          unless system("git commit -m 'Initial commit'")
            raise "could not git commit -m 'Initial commit'"
          end
        end

        def git_add_remote_origin
          unless system("git remote add origin git@github.com:#{project_config.org_slash_project}.git")
            raise "could not git remote add origin git@github.com:#{project_config.org_slash_project}.git"
          end
        end

        def git_branch_main
          unless system("git branch -M main")
            raise "could not git branch -M main"
          end
        end

        def push_to_github
          unless system("git push -u origin main")
            raise "could not git push -u origin main"
          end
        end
      end
    end
  end
end
