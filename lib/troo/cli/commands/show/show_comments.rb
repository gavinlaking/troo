module Troo
  module Commands
    class ShowComments
      attr_reader :id

      class << self
        def dispatch(id = nil, options = {})
          new(id, options).render
        end
      end

      def initialize(id = nil, options = {})
        @id, @options = id, options
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
        resource.comment_presenter(options).show
      end

      def error
        "#{type.capitalize} cannot be found."
      end

      def no_default?
        id.nil? && resource.nil?
      end

      def no_default
        "Specify an <id> or use 'troo default #{type} <id>' " \
        "to set a default #{type} first."
      end

      def type
        'card'
      end

      def resource
        @resource ||= Troo::Card.retrieve(id)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end
    end
  end
end
