require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class BundlerConfigGenerator < ProjectGenerator
          def template_path
            [".bundle", "config.erb"]
          end

          def foobara_dir
            super || "../foobara"
          end
        end
      end
    end
  end
end
