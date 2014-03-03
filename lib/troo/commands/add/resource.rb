module Troo
  module Commands
    module Add
      class Resource
        attr_reader :id, :value

        class << self
          def dispatch(value, id = nil, options = {})
            new(value, id, options).add
          end
        end

        def initialize(value, id = nil, options = {})
          @value, @id, @options = value, id, options
        end

        private

        def options
          defaults.merge!(@options)
        end

        def defaults
          { refresh: false }
        end

        def no_resource?
          resource.nil?
        end
      end
    end
  end
end
