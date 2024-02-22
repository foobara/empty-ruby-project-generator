require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class LibGenerator < ProjectGenerator
          def template_path
            ["lib", "domain.rb.erb"]
          end

          def target_path
            *path, file = full_project_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["lib", *path, file]
          end
        end
      end
    end
  end
end
