module Troo
  module Commands
    module Add
      class Resource
        attr_reader :id, :value

        class << self
          def dispatch(value, id = nil)
            new(value, id).add
          end
        end

        def initialize(value, id = nil)
          @value, @id = value, id
        end
      end
    end
  end
end
