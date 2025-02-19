require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class GemfileGenerator < ProjectGenerator
          def template_path
            "Gemfile.erb"
          end
        end
      end
    end
  end
end
