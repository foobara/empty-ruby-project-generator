require "English"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig < Foobara::Model
        attributes do
          # This is more analogous to the github organization than it is to the Foobara organization, though often would
          # be both.
          organization_name :string, :allow_nil
          # This would be like SomeProjectName for some-project-name.git on github.
          project_name :string, :required
          # This specifies the module nesting for generated files for this project. It might have prefixes left out of
          # the project_name. It will default to Org::Project
          full_module_name :string
          description :string, default: "No description. Add one."
          author_names [:string]
          author_emails [:string]
          homepage_url :string
          # Probably need a better default such as not licensed.
          license :string, default: "MIT"
        end

        attr_accessor :full_module_path,
                      :full_project_path,
                      :full_project_name,
                      :module_name,
                      :module_path,
                      :project_path

        def initialize(attributes = nil, options = {})
          if attributes
            allowed_keys = %i[
              project_name
              full_module_name
              description
              author_names
              author_emails
              homepage_url
              organization_name
              license
            ]

            invalid_keys = attributes.keys - allowed_keys
            unless invalid_keys.empty?
              # :nocov:
              raise ArgumentError, "Invalid options #{invalid_keys} expected only #{allowed_keys}"
              # :nocov:
            end
          end

          project_name = attributes[:project_name]
          description = attributes[:description]
          author_names = attributes[:author_names]
          author_emails = attributes[:author_emails]
          homepage_url = attributes[:homepage_url]
          organization_name = attributes[:organization_name]
          license = attributes[:license] || "MIT"

          has_organization = organization_name && !organization_name.empty?

          organization_name = nil unless has_organization

          full_project_name = [*organization_name, project_name].join("::")
          full_project_path = full_project_name.split("::")
          full_module_name = attributes[:full_module_name] || full_project_name
          full_module_path = full_module_name.split("::")

          module_name = full_module_name.gsub(/^#{organization_name}::/, "")
          module_path = module_name.split("::")

          project_path = project_name.split("::")

          author_names ||= begin
            # TODO: dump a git config file in CI so we don't have to skip this
            # :nocov:
            name = `git config --get user.name`

            if $CHILD_STATUS.exitstatus == 0
              [name.strip]
            else
              raise "Must set author_names because we can't get it from git for some reason"
            end
            # :nocov:
          end

          author_emails ||= begin
            # :nocov:
            email = `git config --get user.email`

            if $CHILD_STATUS.exitstatus == 0
              [email.strip]
            else
              raise "Must set author_emails because we can't get it from git for some reason"
            end
            # :nocov:
          end

          homepage_url ||= "https://github.com/#{org_slash_project_kebab(organization_name, module_name)}"

          super(
            {
              project_name:,
              description:,
              author_names:,
              author_emails:,
              homepage_url:,
              organization_name:,
              license:,
              full_module_name:
            },
            options
          )

          self.full_module_path = full_module_path
          self.full_project_name = full_project_name
          self.full_project_path = full_project_path
          self.module_name = module_name
          self.module_path = module_path
          self.project_path = project_path
        end

        def kebab_case_project_name
          Util.kebab_case(project_path.join)
        end

        def kebab_case_full_project_name
          Util.kebab_case(full_project_path.join)
        end

        def org_slash_project_kebab(organization_name = self.organization_name, project_name = self.project_name)
          org_part = Util.kebab_case(organization_name)&.gsub("::", "-")
          project_part = Util.kebab_case(project_name).gsub("::", "-")

          if org_part.nil? || org_part.empty?
            project_part
          else
            "#{org_part}/#{project_part}"
          end
        end

        def org_slash_project_underscore
          org_slash_project_kebab.gsub("-", "_")
        end

        def project_lib_file_path
          full_project_path.map { |part| Util.underscore(part) }.join("/")
        end
      end
    end
  end
end
