require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class BinConsoleGenerator < ProjectGenerator
          def template_path
            ["lib", "domain.rb.erb"]
          end

          def target_path
            ["lib", underscore_organization_name, "#{underscore_domain_name}.rb"]
          end
        end
      end
    end
  end
end
