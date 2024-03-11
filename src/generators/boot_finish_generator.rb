require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class SpecHelperGenerator < ProjectGenerator
          def template_path
            ["spec", "spec_helper.rb.erb"]
          end
        end
      end
    end
  end
end
