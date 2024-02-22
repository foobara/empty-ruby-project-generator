require_relative "generate_empty_ruby_project"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class WriteEmptyRubyProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs do
          raw_manifest :associative_array
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
          self.paths_to_source_code = run_subcommand!(GenerateEmptyRubyProject, manifest: raw_manifest)
        end

        def run_post_generation_tasks
          add_foobara_to_bundler_config
          bundle_install
          rubocop_autocorrect
        end
      end
    end
  end
end
