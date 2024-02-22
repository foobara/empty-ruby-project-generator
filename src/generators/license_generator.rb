require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class LicenseGenerator < ProjectGenerator
          def template_path
            "LICENSE.txt.erb"
          end
        end
      end
    end
  end
end
