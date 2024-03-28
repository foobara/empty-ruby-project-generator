require "English"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig < Foobara::Model
        attributes do
          name :string, "Name can be the directory to create or optionally org/directory. " \
                        "The org will be used as the github org and " \
                        "the directory will be used as the github repository." \
                        "For example, `some-org-on-github/some-repository-name` would create " \
                        "a project modules of `SomeOrgOnGithub::SomeRepositoryName` " \
                        "(unless you override the module name.)"
          # This specifies the module nesting for generated files for this project. It might have prefixes left out of
          # the project_name. It will default to Org::Project
          full_module_name :string, "If you want a different module name than the one inferred from the name input " \
                                    "then specify it with this option."
          description :string, default: "No description. Add one."
          author_names [:string]
          author_emails [:string]
          homepage_url :string
          # Probably need a better default such as not licensed.
          license :string, default: "None specified yet"
        end

        def kebab_case_project_name
          Util.kebab_case(project_module_path.join)
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

        def organization_name
          @organization_name ||= begin
            org_and_project = name.split("/")

            if org_and_project.size == 2
              org_and_project.first
            end
          end
        end

        def project_name
          @project_name ||= name.split("/").last
        end

        def project_module_path
          @project_module_path ||= kebab_to_module_path(project_name)
        end

        def project_module_name
          @project_module_name ||= project_module_path.join("::")
        end

        def organization_module_path
          @organization_module_path ||= kebab_to_module_path(organization_name)
        end

        def organization_module_name
          @organization_module_name ||= organization_module_path.join("::")
        end

        # TODO: These two are not great names. Should have the word "module" in them.
        def full_project_path
          @full_project_path ||= full_module_name&.split("::") || [*organization_module_path, *project_module_path]
        end

        def full_project_name
          @full_project_name ||= [organization_module_name, project_module_name].compact.join("::")
        end

        def author_names
          @author_names ||= begin
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
        end

        def author_emails
          @author_emails ||= begin
            # :nocov:
            email = `git config --get user.email`

            if $CHILD_STATUS.exitstatus == 0
              [email.strip]
            else
              raise "Must set author_emails because we can't get it from git for some reason"
            end
            # :nocov:
          end
        end

        def homepage_url
          @homepage_url ||= "https://github.com/#{org_slash_project_kebab(organization_name, project_module_name)}"
        end

        private

        def kebab_to_module_path(kebab)
          if kebab
            kebab.split("_").map { |part| Util.classify(part.gsub("-", "_")) }
          else
            []
          end
        end
      end
    end
  end
end
