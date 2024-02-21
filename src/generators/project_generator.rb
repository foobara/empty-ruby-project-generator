# Where to put files?
# let's examine an error...
# if an error belongs to a command, let's put it in <command path>/errors/<error_name>.ts
# if an error belongs to a domain, let's put it in <domain path>/errors/<error_name>.ts
# if an error belongs to an organization, let's put it in <organization path>/errors/<error_name>.ts
# if an error belongs to a base processor, let's put it in base/processors/<processor path>/<error_name>.ts
# if an error belongs to nothing, let's put it in errors/<error_name>.ts
#
# so what is the official logic?
# if parent is a domain or org or nil,
# then we need to insert "errors" before the last element in the scoped_path.
# This is to help make the commands more first-class.
# otherwise, the thing will already be out of site. We could prepend the path with "base" and <parent_category>.
#
# Might just be safer though to leverage the parent's target_dir.
#
# So that logic would be...
# if parent is domain, nil, or org:
# <parent_target_dir>/errors/<error_name>.ts
# else
# <parent_target_dir>/<error_name>.ts

module Foobara
  module Generators
    class EmptyRubyProjectGenerator
      module Generators
        class ProjectGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when ProjectConfig
                [
                  Generators::ProjectGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def templates_dir
            "#{__dir__}/../../templates"
          end

          def ==(other)
            self.class == other.class && root_manifest == other.root_manifest
          end

          def hash
            root_manifest.hash
          end
        end
      end
    end
  end
end
