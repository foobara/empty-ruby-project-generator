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
          # TODO: implement
          # return
          # add_foobara_to_bundler_config
          # bundle_install
          # rubocop_autocorrect
        end
      end
    end
  end
end
