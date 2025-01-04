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
                  Generators::BootFinishGenerator,
                  Generators::ChangelogGenerator,
                  Generators::CiYamlGenerator,
                  Generators::GemspecGenerator,
                  Generators::GitignoreGenerator,
                  Generators::InitialModuleGenerator,
                  Generators::InitialSpecGenerator,
                  Generators::LibGenerator,
                  Generators::LicenseGenerator,
                  Generators::ReadmeGenerator,
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
        end
      end
    end
  end
end
