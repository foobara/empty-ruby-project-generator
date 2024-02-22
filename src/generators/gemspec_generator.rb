require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class GemspecGenerator < ProjectGenerator
          def template_path
            "gemspec.gemspec.erb"
          end

          def target_path
            "#{kebab_case_project_name}.gemspec"
          end
        end
      end
    end
  end
end
