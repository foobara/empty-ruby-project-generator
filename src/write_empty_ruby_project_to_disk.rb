require "fileutils"
require "extract_repo"
require_relative "generate_empty_ruby_project"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class WriteEmptyRubyProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "ruby-project"
          end
        end

        depends_on GenerateEmptyRubyProject, ::ExtractRepo

        inputs do
          extract_from_repo :string
          paths_to_extract [:string]
          delete_extracted :boolean, default: true
          project_config ProjectConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          create_output_directory_if_needed
          if extract_from_another_repo?
            extract_from_another_repo
          end
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          output
        end

        attr_accessor :use_git_failed, :push_to_github_failed

        def create_output_directory_if_needed
          FileUtils.mkdir_p output_directory
        end

        def extract_from_another_repo?
          !!extract_from_repo
        end

        def extract_from_another_repo
          run_subcommand!(
            ExtractRepo,
            repo_url_or_path: extract_from_repo,
            paths: paths_to_extract,
            delete_extracted:,
            output_path: output_directory
          )
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          project_config.org_slash_project_kebab
        end

        def push_to_github?
          project_config.push_to_github
        end

        def turn_on_rbenv_bundler?
          project_config.turn_on_rbenv_bundler
        end

        def use_git?
          project_config.use_git
        end

        def generate_file_contents
          puts "generating..."
          # TODO: just pass this in as the inputs instead of the command??
          self.paths_to_source_code = run_subcommand!(GenerateEmptyRubyProject, project_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            bundle_install
            make_bin_files_executable
            rubocop_autocorrect

            if use_git?
              git_init unless extract_from_another_repo?
              git_add_all
              git_commit
              git_branch_main

              if push_to_github?
                github_create_repo
                git_add_remote_origin
                push_to_github
              end

              if turn_on_rbenv_bundler?
                rbenv_bundler_on
              end
            end
          end
        end

        def bundle_install
          puts "bundling..."
          cmd = "bundle install"

          if Bundler.respond_to?(:with_unbundled_env)
            Bundler.with_unbundled_env do
              run_cmd_and_return_output(cmd)
            end
          else
            # :nocov:
            run_cmd_and_return_output(cmd)
            # :nocov:
          end
        end

        def rubocop_autocorrect
          puts "linting..."

          cmd = "bundle exec rubocop --no-server -A"

          if Bundler.respond_to?(:with_unbundled_env)
            Bundler.with_unbundled_env do
              run_cmd_and_return_output(cmd)
            end
          else
            # :nocov:
            run_cmd_and_return_output(cmd)
            # :nocov:
          end
        rescue CouldNotExecuteError => e
          # :nocov:
          warn e.message
          # :nocov:
        end

        def make_bin_files_executable
          Dir["bin/*"].each do |file|
            if File.file?(file)
              cmd = "chmod u+x #{file}"
              begin
                run_cmd_and_return_output(cmd)
              rescue CouldNotExecuteError => e
                # :nocov:
                warn e.message
                # :nocov:
              end
            end
          end
        end

        def git_init
          return if use_git_failed

          cmd = "git init"
          run_cmd_and_return_output(cmd)
        rescue CouldNotExecuteError => e
          # :nocov:
          self.use_git_failed = true
          warn e.message
          # :nocov:
        end

        def git_add_all
          return if use_git_failed

          cmd = "git add ."
          run_cmd_and_return_output(cmd)
        rescue CouldNotExecuteError => e
          # :nocov:
          self.use_git_failed = true
          warn e.message
          # :nocov:
        end

        def git_commit
          return if use_git_failed

          cmd = "git commit -m 'Create ruby project files'"
          run_cmd_and_return_output(cmd)
        rescue CouldNotExecuteError => e
          # :nocov:
          self.use_git_failed = true
          warn e.message
          # :nocov:
        end

        def github_create_repo
          return if push_to_github_failed

          puts "pushing to github..."

          cmd = "gh repo create --private #{project_config.org_slash_project_kebab}"
          exit_status = run_cmd_and_write_output(cmd, raise_if_fails: false)

          unless exit_status&.success?
            self.push_to_github_failed = true
          end
        end

        def git_add_remote_origin
          return if push_to_github_failed

          cmd = "git remote add origin git@github.com:#{project_config.org_slash_project_kebab}.git"
          exit_status = run_cmd_and_write_output(cmd, raise_if_fails: false)

          unless exit_status&.success?
            # :nocov:
            self.push_to_github_failed = true
            # :nocov:
          end
        end

        def git_branch_main
          return if use_git_failed

          cmd = "git branch -M main"
          exit_status = run_cmd_and_write_output(cmd, raise_if_fails: false)

          unless exit_status&.success?
            # :nocov:
            self.use_git_failed = true
            # :nocov:
          end
        end

        def push_to_github
          return if push_to_github_failed

          cmd = "git push -u origin main"
          run_cmd_and_return_output(cmd)
        rescue CouldNotExecuteError => e
          self.push_to_github_failed = true
          warn e.message
        end

        def rbenv_bundler_on
          cmd = "rbenv bundler on"
          run_cmd_and_write_output(cmd, raise_if_fails: false)
        end

        def output
          "\nDone. #{stats}"
        end
      end
    end
  end
end
