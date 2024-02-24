require_relative "generate_empty_ruby_project"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class WriteEmptyRubyProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
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
      end
    end
  end
end
