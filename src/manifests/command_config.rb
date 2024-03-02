require "English"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class CommandConfig < Foobara::Model
        attributes do
          command_name :string, :required
          description :string
          organization_name :string
          domain_name :string
          module_path [:string]
        end

        def initialize(attributes = nil, options = {})
          module_path = attributes[:module_path]
          command_name = attributes[:command_name]
          description = attributes[:description]
          organization_name = attributes[:organization_name]
          domain_name = attributes[:domain_name]

          if organization_name.nil? && domain_name.nil? && module_path.nil?
            module_path = command_name.split("::")

            *prefix, command_name = module_path

            *organization_parts, domain_name = prefix

            unless organization_parts.empty?
              organization_name = organization_parts.join("::")
            end
          end

          super(
            {
              command_name:,
              description:,
              organization_name:,
              domain_name:,
              module_path:
            },
            options
          )
        end
      end
    end
  end
end
