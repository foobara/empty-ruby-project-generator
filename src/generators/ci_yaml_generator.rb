module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class CiYamlGenerator < Foobara::FilesGenerator
          def template_path
            [".github", "workflows", "ci.yml.erb"]
          end
        end
      end
    end
  end
end
