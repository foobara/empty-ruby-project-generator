require "English"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig < Foobara::Model
        attributes do
          organization_name :string, :allow_nil
          project_name :string, :required
          full_module_name :string
          description :string, :required
          author_names [:string]
          author_emails [:string]
          homepage_url :string
          license :string, default: "MIT"
          foobara_dir :string
        end

        attr_accessor :full_module_path,
                      :full_project_path,
                      :full_project_name,
                      :module_name,
                      :module_path

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
          # TODO: very strange interface here...
          # "" to indicate no org and nil to indicate infer it from the project name...
          organization_name = attributes[:organization_name]

          no_org = organization_name&.empty?
          organization_name = nil if no_org

          license = attributes[:license] || "MIT"
          full_project_name = [*organization_name, project_name].join("::")
          full_project_path = full_project_name.split("::")
          full_module_name = attributes[:full_module_name] || full_project_name
          full_module_path = full_module_name.split("::")

          unless no_org
            organization_name ||= full_project_path.first
          end

          module_name = full_module_name.gsub(/^#{organization_name}::/, "")
          module_path = module_name.split("::")

          project_name = full_project_name.gsub(/^#{organization_name}::/, "")

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

          homepage_url ||= "https://github.com/#{org_slash_project(organization_name, module_name)}"

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
        end

        def kebab_case_project_name
          Util.kebab_case(full_project_path.join)
        end

        def org_slash_project(organization_name = self.organization_name, module_name = self.module_name)
          org_part = Util.kebab_case(organization_name)&.gsub("::", "-")
          project_part = Util.kebab_case(module_name).gsub("::", "-")

          if org_part.nil? || org_part.empty?
            project_part
          else
            "#{org_part}/#{project_part}"
          end
        end

        def project_lib_file_path
          full_project_path.map { |part| Util.underscore(part) }.join("/")
        end
      end
    end
  end
end
