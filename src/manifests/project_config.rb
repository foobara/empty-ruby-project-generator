module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ProjectConfig
        attr_accessor :domain_name, :organization_name

        def initialize(domain_name:, organization_name: nil)
          self.domain_name = domain_name
          self.organization_name = organization_name
        end

        def kebab_case_project_name
          Util.kebab_case(domain_name)
        end
      end
    end
  end
end
