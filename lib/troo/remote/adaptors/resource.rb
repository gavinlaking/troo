module Troo
  module Remote
    module Adaptors
      class Resource
        attr_reader :resource

        class << self
          def adapt(resource)
            new(resource).adapted
          end
        end

        def initialize(resource)
          @resource = resource
        end
      end
    end
  end
end
