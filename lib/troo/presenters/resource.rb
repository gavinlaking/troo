module Troo
  module Presenters
    class Resource
      include DecoratorHelpers

      class << self
        # @param  []
        # @param  [Hash]
        # @return [String]
        def list_view(klass, options = {})
          new(klass, options).list_view
        end
      end

      # @param  []
      # @param  [Hash]
      # @return [Troo::Presenters::Resource]
      def initialize(klass, options = {})
        @klass, @options = klass, options
      end

      # @return [String]
      def list_view
        [id, name, default].compact.join(' ') + "\n"
      end

      private

      attr_reader :klass

      def id
        brackets(formatted_id)
      end

      def formatted_id
        return highlight(resource_id) if card?
        resource_id
      end

      def name
        return formatted_name if card?
        highlight(formatted_name)
      end

      def formatted_name
        Troo::Wordwrap.this(resource_name, prune: true)
      end

      def default
        return '*' if resource_default?
      end

      def resource_id
        return klass.short_id if card?
        klass.id
      end

      def resource_name
        (klass.name && klass.name.chomp) || 'N/A'
      end

      def resource_default?
        klass.default?
      end

      def card?
        klass.type == :card
      end

      def highlight(value)
        Troo::Formatter.highlight(value, options)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          ansicolor: true,
          colour:    colour.fetch(klass.type, nil),
          underline: true
        }
      end

      def colour
        {
          board:    Esc.blue,
          card:     Esc.magenta,
          list:     Esc.green,
          comments: Esc.cyan,
          member:   Esc.white
        }
      end
    end
  end
end
