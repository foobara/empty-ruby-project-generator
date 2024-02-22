require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class ChangelogGenerator < ProjectGenerator
          def template_path
            "CHANGELOG.md.erb"
          end
        end
      end
    end
  end
end
