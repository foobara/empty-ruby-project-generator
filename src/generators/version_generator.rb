require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class VersionGenerator < ProjectGenerator
          def template_path
            ["version.rb.erb"]
          end
        end
      end
    end
  end
end
