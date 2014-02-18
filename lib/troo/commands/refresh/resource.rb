module Troo
  module Commands
    module Refresh
      class Resource
        attr_reader :id

        class << self
          def dispatch(id = nil)
            new(id).refresh
          end
        end

        def initialize(id = nil)
          @id = id
        end

        def refresh
          if resource.one?
            success
          elsif resource.count > 1
            many_success
          else
            not_found
          end
        end

        private

        def many_success
          "Multiple #{type}s refreshed."
        end

        def success
          "'#{resource_name}' refreshed."
        end

        def not_found
          return [error, no_default].join(' ') if id
          error
        end

        def error
          "#{type.capitalize} cannot be found."
        end

        def no_default
          "Specify an <id> or use 'troo default #{type} <id>' " \
          "to set a default #{type} first."
        end

        def resource_name
          resource.first.decorator.name
        end
      end
    end
  end
end
