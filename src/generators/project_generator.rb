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
                  Generators::CiYamlGenerator,
                  Generators::BinConsoleGenerator
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

          def project_name
            domain_name
          end

          def kebab_case_project_name
            Util.kebab_case(project_name)
          end

          def has_organization?
            !!organization_name
          end

          def underscore_project_name
            Util.underscore(project_name)
          end

          def underscore_domain_name
            Util.underscore(domain_name)
          end

          def underscore_organization_name
            Util.underscore(organization_name)
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
