module Foobara
  module Generators
    class GenerateEmptyRubyProject < Foobara::Generators::Generate
      class MissingManifestError < RuntimeError; end

      possible_error MissingManifestError

      inputs manifest_data: :duck

      def execute
        generate_base_files

        add_root_manifest_to_set_of_elements_to_generate

        each_element_to_generate do
          generate_element
        end

        generate_generated_files_json

        run_post_generation_tasks

        paths_to_source_code
      end

      def run_post_generation_tasks
        add_foobara_to_bundler_config
        bundle_install
        rubocop_autocorrect
      end

      def validate
        if raw_manifest.nil? && manifest_url.nil?
          # :nocov:
          add_runtime_error(MissingManifestError.new(message: "Either raw_manifest or manifest_url must be given"))
          # :nocov:
        end
      end

      attr_accessor :command_manifest, :manifest_data

      def base_generator
        Generators::EmptyRubyProjectGenerator
      end

      def templates_dir
        "#{__dir__}/../templates"
      end

      def add_root_manifest_to_set_of_elements_to_generate
        elements_to_generate << manifest
      end

      def manifest
        @manifest ||= Manifest::RootManifest.new(manifest_data)
      end

      def generate_base_files
        Dir["#{templates_dir}/base/**/*.ts"].each do |file_path|
          pathname = Pathname.new(file_path)

          key = pathname.relative_path_from(templates_dir)

          paths_to_source_code[key.to_s] = File.read(file_path)
        end
      end
    end
  end
end
