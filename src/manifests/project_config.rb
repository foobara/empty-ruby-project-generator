require "English"
module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig
        attr_accessor :full_module_name,
                      :full_module_path,
                      :full_project_name,
                      :full_project_path,
                      :module_name,
                      :module_path,
                      :author_names,
                      :author_emails,
                      :description,
                      :homepage_url,
                      :license,
                      :org_name

        def initialize(
          full_project_name,
          description:, full_project_path: nil,
          author_names: nil,
          author_emails: nil,
          homepage_url: nil,
          org: nil,
          license: "MIT"
        )
          self.full_project_name = full_project_name
          self.full_project_path = full_project_name.split("::")
          self.full_module_name = full_project_name
          self.full_module_path = full_module_name.split("::")

          self.org_name = org || self.full_project_path.first

          self.module_name = full_project_name.gsub(/^#{org}::/, "")
          self.module_path = module_name.split("::")

          self.author_names = if author_names
                                author_names
                              else
                                name = `git config --get user.name`

                                if $CHILD_STATUS.exitstatus == 0
                                  [name.strip]
                                else
                                  # :nocov:
                                  raise "Must set author_names because we can't get it from git for some reason"
                                  # :nocov:
                                end
                              end

          self.author_emails = if author_emails
                                 author_emails
                               else
                                 name = `git config --get user.email`

                                 if $CHILD_STATUS.exitstatus == 0
                                   [name.strip]
                                 else
                                   # :nocov:
                                   raise "Must set author_names because we can't get it from git for some reason"
                                   # :nocov:
                                 end
                               end

          self.homepage_url = if homepage_url
                                homepage_url
                              else
                                org_part = Util.kebab_case(org_name).gsub("::", "-")
                                project_part = Util.kebab_case(module_name).gsub("::", "-")

                                "https://github.com/#{org_part}/#{project_part}"
                              end
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
