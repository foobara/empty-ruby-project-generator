require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class BootFinishGenerator < ProjectGenerator
          def template_path
            ["boot", "finish.rb.erb"]
          end
        end
      end
    end
  end
end
