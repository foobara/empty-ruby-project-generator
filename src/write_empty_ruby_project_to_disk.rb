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

        depends_on GenerateEmptyRubyProject

        inputs do
          project_config ProjectConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          generate_file_contents
          generate_generated_files_json
          delete_old_files_if_needed
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          project_config.org_slash_project_kebab
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
            git_init
            git_add_all
            git_commit
            github_create_repo
            git_add_remote_origin
            git_branch_main
            push_to_github
            rbenv_bundler_on
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
              raise "could not bundle exec rubocop -A. #{stderr.read}"
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

        def git_init
          unless system("git init")
            # :nocov:
            raise "could not git init"
            # :nocov:
          end
        end

        def git_add_all
          unless system("git add .")
            # :nocov:
            raise "could not git add ."
            # :nocov:
          end
        end

        def git_commit
          # TODO: set author/name with git config in CI so we don't have to skip this
          # :nocov:
          Open3.popen3("git commit -m 'Initial commit'") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              raise "could not git commit -m 'Initial commit'. #{stderr.read}"
            end
          end
          # :nocov:
        end

        attr_accessor :origin_set, :pushed

        def github_create_repo
          cmd = "gh repo create --public --push --source=. #{project_config.org_slash_project_kebab}"

          Open3.popen3(cmd) do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            if exit_status.success?
              # :nocov:
              self.origin_set = true
              self.pushed = true
              # :nocov:
            else
              warn "WARNING: could not #{cmd}"
            end
          end
        end

        def git_add_remote_origin
          return if origin_set

          unless system("git remote add origin git@github.com:#{project_config.org_slash_project_kebab}.git")
            # :nocov:
            raise "could not git remote add origin git@github.com:#{project_config.org_slash_project_kebab}.git"
            # :nocov:
          end
        end

        def git_branch_main
          unless system("git branch -M main")
            # :nocov:
            raise "could not git branch -M main"
            # :nocov:
          end
        end

        def push_to_github
          return if pushed

          Open3.popen3("git push -u origin main") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              warn "WARNING: could not git push -u origin main \n #{stderr.read}"
            end
          end
        end

        def rbenv_bundler_on
          # :nocov:
          Open3.popen3("rbenv bundler on") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              warn "WARNING: could not rbenv bundler on \n #{stderr.read}"
            end
          end
          # :nocov:
        end
      end
    end
  end
end
