module Troo
  module Commands
    class Add
      attr_reader :id, :value

      class << self
        # @param  []
        # @param  []
        # @param  [Hash]
        # @return []
        def dispatch(value, id = nil, options = {})
          new(value, id, options).add
        end
      end

      # @param  []
      # @param  []
      # @param  [Hash]
      # @return []
      def initialize(value, id = nil, options = {})
        @value, @id, @options = value, id, options
      end

      # @return []
      def add
        return success if create
        error
      end

      private

      def success
        ['New', type.to_s, quoted, 'created.'].compact.join(' ')
      end

      def error
        return 'Could not create resource.' if no_type?
        "#{klass} could not be created."
      end

      def quoted
        type == :comment ? nil : "'#{value}'"
      end

      def create
        return false if no_type?

        if type == :board
          @create ||= remote.with(value)
        else
          return false if no_local?
          @create ||= remote.with(resource.external_id, value)
        end
      end

      def remote
        Object.const_get('Troo::Remote::Persistence::' + klass)
      end

      def no_local?
        resource.nil?
      end

      def resource
        @resource ||= local.retrieve(id)
      end

      def local
        Object.const_get('Troo::' + mapping.fetch(type))
      end

      def klass
        type.to_s.capitalize
      end

      def no_type?
        type == :none
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

      def mapping
        {
          comment: 'Card',
          board:   'Board',
          list:    'Board',
          card:    'List'
        }
      end
    end
  end
end
