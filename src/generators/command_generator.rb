require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class CommandGenerator < Foobara::FilesGenerator
          def template_path
            ["src", "command.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          alias command_config relevant_manifest

          def templates_dir
            "#{__dir__}/../../templates"
          end

          # TODO: promote this up to base project
          def ==(other)
            self.class == other.class && command_config == other.command_config
          end

          def hash
            command_config.hash
          end
        end
      end
    end
  end
end
