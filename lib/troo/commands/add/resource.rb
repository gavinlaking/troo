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

        private

        def no_resource?
          resource.nil?
        end
      end
    end
  end
end
