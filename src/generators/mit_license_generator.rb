require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class MitLicenseGenerator < ProjectGenerator
          def template_path
            "LICENSE-MIT.txt.erb"
          end

          def filename
            "LICENSE-MIT.txt"
          end

          def spdx_identifier
            "MIT"
          end

          def uri
            "https://opensource.org/licenses/MIT"
          end
        end
      end
    end
  end
end
