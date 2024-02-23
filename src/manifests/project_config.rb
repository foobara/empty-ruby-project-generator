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
          license :string
        end

        attr_accessor :full_module_path,
                      :full_module_name,
                      :full_project_path,
                      :module_name,
                      :module_path

        def initialize(
          full_project_name:,
          description:,
          author_names: nil,
          author_emails: nil,
          homepage_url: nil,
          org: nil,
          license: "MIT"
        )
          full_project_path = full_project_name.split("::")
          full_module_name = full_project_name
          full_module_path = full_module_name.split("::")

          organization_name ||= full_project_path.first

          module_name = full_project_name.gsub(/^#{org}::/, "")
          module_path = module_name.split("::")

          author_names ||= begin
            name = `git config --get user.name`

            if $CHILD_STATUS.exitstatus == 0
              [name.strip]
            else
              # :nocov:
              raise "Must set author_names because we can't get it from git for some reason"
              # :nocov:
            end
          end

          author_emails ||= begin
            email = `git config --get user.email`

            if $CHILD_STATUS.exitstatus == 0
              [email.strip]
            else
              # :nocov:
              raise "Must set author_emails because we can't get it from git for some reason"
              # :nocov:
            end
          end

          homepage_url ||= begin
            org_part = Util.kebab_case(organization_name).gsub("::", "-")
            project_part = Util.kebab_case(module_name).gsub("::", "-")

            "https://github.com/#{org_part}/#{project_part}"
          end

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

        def project_lib_file_path
          full_project_path.map { |part| Util.underscore(part) }.join("/")
        end
      end
    end
  end
end
