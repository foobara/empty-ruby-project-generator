require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class Apache2LicenseGenerator < ProjectGenerator
          def template_path
            "LICENSE-APACHE-2.0.txt.erb"
          end

          def filename
            "LICENSE-APACHE-2.0.txt"
          end

          def spdx_identifier
            "Apache-2.0"
          end

          def uri
            "https://www.apache.org/licenses/LICENSE-2.0.txt"
          end
        end
      end
    end
  end
end
