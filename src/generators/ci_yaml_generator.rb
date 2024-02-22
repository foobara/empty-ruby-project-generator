module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class CiYamlGenerator < ProjectGenerator
          def template_path
            [".github", "workflows", "ci.yml.erb"]
          end
        end
      end
    end
  end
end
