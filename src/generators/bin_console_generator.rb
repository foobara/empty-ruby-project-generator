require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class BinConsoleGenerator < ProjectGenerator
          def template_path
            ["bin", "console.erb"]
          end
        end
      end
    end
  end
end
