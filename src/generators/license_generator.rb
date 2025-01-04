require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class LicenseGenerator < ProjectGenerator
          def template_path
            "LICENSE.txt.erb"
          end

          def applicable?
            !!license
          end

          def license_strings
            license.split(" OR ")
          end

          def license_generators
            license_strings.map do |license_string|
              case license_string
              when "MIT"
                MitLicenseGenerator
              when "Apache-2.0"
                Apache2LicenseGenerator
              when "MPL-2.0"
                Mpl2LicenseGenerator
              else
                # :nocov:
                raise "Unknown license string #{license_string}"
                # :nocov:
              end
            end.map do |klass|
              klass.new(relevant_manifest)
            end.sort_by(&:spdx_identifier)
          end

          def dependencies
            license_generators
          end

          def spdx_expression
            license
          end

          def license_message
            licenses = license_strings

            case licenses.size
            when 1
              "This project is licensed under the #{licenses.first} license."
            when 2
              "This project is dual licensed under your choice of the " \
              "#{licenses.first} license and the #{licenses.last} license."
            else
              # :nocov:
              raise "Not sure what to do with #{licenses.size} licenses"
              # :nocov:
            end
          end
        end
      end
    end
  end
end
