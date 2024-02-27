require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class GitignoreGenerator < ProjectGenerator
          def template_path
            ".gitignore.erb"
          end
        end
      end
    end
  end
end
