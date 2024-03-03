require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class InitialSpecGenerator < ProjectGenerator
          def template_path
            ["spec", "initial_spec.rb.erb"]
          end

          def target_path
            *path, file = full_module_path.map { |part| Util.underscore(part) }

            file = "#{file}_spec.rb"

            ["spec", *path, file]
          end
        end
      end
    end
  end
end
