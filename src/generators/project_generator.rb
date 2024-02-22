module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      module Generators
        class ProjectGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when ProjectConfig
                [
                  Generators::CiYamlGenerator
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
            relevant_manifest.hash
          end
        end
      end
    end
  end
end
