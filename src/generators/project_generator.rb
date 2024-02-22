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
                  Generators::BinConsoleGenerator,
                  Generators::ChangelogGenerator,
                  Generators::CiYamlGenerator,
                  Generators::InitialSpecGenerator,
                  Generators::LibGenerator,
                  Generators::SpecHelperGenerator,
                  Generators::VersionGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          alias project_config relevant_manifest

          def templates_dir
            "#{__dir__}/../../templates"
          end

          # TODO: promote this up to base project
          def ==(other)
            self.class == other.class && project_config == other.project_config
          end

          def hash
            project_config.hash
          end
        end
      end
    end
  end
end
