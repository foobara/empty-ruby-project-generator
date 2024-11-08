module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      class ExtractInputs < Foobara::Model
        attributes do
          repo :string, :required
          paths [:string], :required
          delete_extracted :boolean, default: false
        end
      end
    end
  end
end
