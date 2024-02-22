require "pathname"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class GenerateEmptyRubyProject < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        # TODO: implement sugar for using a non-registered class as a type
        inputs do
          project_config :duck, :required
        end

        def execute
          include_non_templated_files

          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          generate_generated_files_json

          paths_to_source_code
        end

        # TODO: move this up the hierarchy
        def include_non_templated_files
          templates_dir_pathname = Pathname.new(templates_dir)

          Dir["#{templates_dir}/**/*"].each do |file_path|
            next if File.directory?(file_path)
            next if file_path.end_with?(".erb")

            file_path = Pathname.new(file_path)

            relative_path = file_path.relative_path_from(templates_dir_pathname)

            paths_to_source_code[relative_path.to_s] = File.read(file_path)
          end
        end

        attr_accessor :command_manifest, :manifest_data

        def base_generator
          Generators::ProjectGenerator
        end

        def templates_dir
          "#{__dir__}/../templates"
        end

        def add_initial_elements_to_generate
          elements_to_generate << project_config
        end

        def manifest
          @manifest ||= Manifest::RootManifest.new(manifest_data)
        end
      end
    end
  end
end
