module Troo
  module Commands
    class ShowComments
      attr_reader :id

      class << self
        # @param  []
        # @return [String]
        def dispatch(id = nil)
          new(id).render
        end
      end

      # @param  []
      # @return []
      def initialize(id = nil)
        @id = id
      end

      # @return [String]
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
        resource.comment_presenter.show
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
    end
  end
end
