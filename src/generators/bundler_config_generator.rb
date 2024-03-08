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
            match = /Set for the current user \([^\)]+\): "([^"]+)"/.match(`bundle config get local.foobara`)

            if match
              # :nocov:
              match[1]
              # :nocov:
            else
              # :nocov:
              super || "../foobara"
              # :nocov:
            end
          end
        end
      end
    end
  end
end
