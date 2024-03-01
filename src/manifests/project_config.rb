require "English"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig < Foobara::Model
        attributes do
          full_project_name :string, :required
          description :string, :required
          author_names [:string]
          author_emails [:string]
          homepage_url :string
          organization_name :string
          license :string, default: "MIT"
          foobara_dir :string
        end

        attr_accessor :full_module_path,
                      :full_module_name,
                      :full_project_path,
                      :module_name,
                      :module_path

        def initialize(attributes = nil, options = {})
          allowed_keys = %i[full_project_name description author_names author_emails homepage_url organization_name
                            license]

          invalid_keys = options.keys - allowed_keys
          unless invalid_keys.empty?
            # :nocov:
            raise ArgumentError, "Invalid options #{invalid_keys} expected only #{allowed_keys}"
            # :nocov:
          end

          full_project_name = attributes[:full_project_name]
          description = attributes[:description]
          author_names = attributes[:author_names]
          author_emails = attributes[:author_emails]
          homepage_url = attributes[:homepage_url]
          organization_name = attributes[:organization_name]
          license = attributes[:license] || "MIT"

          full_project_path = full_project_name.split("::")
          full_module_name = full_project_name
          full_module_path = full_module_name.split("::")

          organization_name ||= full_project_path.first

          module_name = full_project_name.gsub(/^#{organization_name}::/, "")
          module_path = module_name.split("::")

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
            full_project_name:,
            description:,
            author_names:,
            author_emails:,
            homepage_url:,
            organization_name:,
            license:
          )

          self.full_module_path = full_module_path
          self.full_module_name = full_module_name
          self.full_project_path = full_project_path
          self.module_name = module_name
          self.module_path = module_path
        end

        def kebab_case_project_name
          Util.kebab_case(full_project_path.join)
        end

        def org_slash_project(organization_name = self.organization_name, module_name = self.module_name)
          org_part = Util.kebab_case(organization_name).gsub("::", "-")
          project_part = Util.kebab_case(module_name).gsub("::", "-")

          if org_part.empty?
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
