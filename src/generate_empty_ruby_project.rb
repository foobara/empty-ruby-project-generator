require "pathname"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class GenerateEmptyRubyProject < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs ProjectConfig

        def execute
          include_non_templated_files

          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        def base_generator
          Generators::ProjectGenerator
        end

        def templates_dir
          "#{__dir__}/../templates"
        end

        def add_initial_elements_to_generate
          elements_to_generate << project_config
        end

        def project_config
          @project_config ||= ProjectConfig.new(inputs)
        end
      end
    end
  end
end
