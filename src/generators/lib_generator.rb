require_relative "project_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class LibGenerator < ProjectGenerator
          def template_path
            ["lib", "project_require_file.rb.erb"]
          end

          def target_path
            *path, file = org_slash_project_underscore.split("/")

            ["lib", *path, "#{file}.rb"]
          end

          def path_to_src
            up = [".."] * (target_path.size - 1)

            [*up, "src"].join("/")
          end
        end
      end
    end
  end
end
