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
            "#{kebab_case_full_project_name}.gemspec"
          end

          def current_foobara_version
            Gem.loaded_specs["foobara"].version
          end
        end
      end
    end
  end
end
