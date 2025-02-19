require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class RubyVersionGenerator < ProjectGenerator
          def template_path
            ".ruby-version.erb"
          end

          def current_ruby_version
            RUBY_VERSION
          end
        end
      end
    end
  end
end
