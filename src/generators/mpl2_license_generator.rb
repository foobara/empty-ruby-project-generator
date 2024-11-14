require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class Mpl2LicenseGenerator < ProjectGenerator
          def template_path
            "LICENSE-MPL-2.0.txt.erb"
          end

          def filename
            "LICENSE-MPL-2.0.txt"
          end

          def spdx_identifier
            "MPL-2.0"
          end

          def uri
            "https://www.mozilla.org/MPL/2.0/"
          end
        end
      end
    end
  end
end
