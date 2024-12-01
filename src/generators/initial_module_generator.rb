require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class InitialModuleGenerator < ProjectGenerator
          def template_path
            ["src", "initial_module.rb.erb"]
          end

          def target_path
            *path, file = full_project_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          def module_path
            full_project_path
          end
        end
      end
    end
  end
end
