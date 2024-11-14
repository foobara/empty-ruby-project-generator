require "foobara/all"
require "foobara/files_generator"

module Foobara
  module Generators
    module EmptyRubyProjectGenerator
      foobara_domain!
    end
  end
end

Foobara::Util.require_directory "#{__dir__}/../../src"
