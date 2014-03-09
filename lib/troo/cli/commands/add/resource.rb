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

        def add
          return success if create
          error
        end

        private

        def success
          ['New', type.to_s, quoted, 'created.'].compact.join(' ')
        end

        def error
          "#{type.to_s.capitalize} could not be created."
        end

        def quoted
          type == :comment ? nil : "'#{value}'"
        end

        def no_resource?
          resource.nil?
        end

        def resource
          return nil if parent.nil?
          parent.retrieve(id)
        end

        def parent
          {
            board:   Troo::Board,
            list:    Troo::Board,
            card:    Troo::List,
            comment: Troo::Card
          }.fetch(type, nil)
        end

        def type
          options.fetch(:type)
        end

        def options
          defaults.merge!(@options)
        end

        def defaults
          {
            type: :none
          }
        end
      end
    end
  end
end
