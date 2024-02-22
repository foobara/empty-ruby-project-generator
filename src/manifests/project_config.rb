module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig
        attr_accessor :full_module_name, :full_path, :full_project_path

        def initialize(full_module_name, project_name_path: nil)
          self.full_module_name = full_module_name
          self.full_path = full_module_name.split("::")
          self.full_project_path = project_name_path || full_path
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
