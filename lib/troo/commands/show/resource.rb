module Troo
  module Commands
    module Show
      class Resource
        attr_reader :id, :type

        class << self
          def dispatch(type = nil, id = nil)
            new(type, id).render
          end
        end

        def initialize(type = nil, id = nil)
          @type, @id = type, id
        end

        def render
          if resource
            presenter
          elsif no_default?
            [error, no_default].join(' ')
          else
            error
          end
        end

        private

        def presenter
          resource.presenter.show
        end

        def error
          "#{type.capitalize} cannot be found."
        end

        def no_default?
          id.nil?
        end

        def no_default
          "Specify an <id> or use 'troo default #{type} <id>' " \
          "to set a default #{type} first."
        end
      end
    end
  end
end
