require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class ReadmeGenerator < ProjectGenerator
          def template_path
            "README.md.erb"
          end

          def license_generator
            return @license_generator if defined?(@license_generator)

            @license_generator = if license
                                   LicenseGenerator.new(relevant_manifest)
                                 end
          end

          def dependencies
            [*license_generator]
          end

          def license_message
            if license_generator
              license_generator.license_message
            else
              "Currently unlicensed."
            end
          end
        end
      end
    end
  end
end
