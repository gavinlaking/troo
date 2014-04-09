module Troo
  class Formatter
    include Virtus.model

    attribute :value,   String
    attribute :options, Troo::Format

    class << self
      # @param  []
      # @param  [Hash]
      # @return []
      def highlight(value, options = {})
        new(value: value, options: options).highlight
      end

      # @param  []
      # @param  [Hash]
      # @return []
      def error(value, options = {})
        defaults = { colour: Esc.red }
        new(value:   value,
            options: defaults.merge!(options)).error
      end

      # @param  []
      # @param  [Integer]
      # @return []
      def wordwrap(value, width = 70)
        new(value:   value,
            options: { align: { width: width } }).wordwrap
      end
    end

    # @return [String]
    def highlight
      if options.ansicolor
        [
          options.colour,
          options.underline,
          formatted_value,
          options.reset
        ].join
      else
        formatted_value
      end
    end

    # @return [String]
    def error
      if options.ansicolor
        [
          options.colour,
          formatted_value,
          options.reset
        ].join
      else
        formatted_value
      end
    end

    # @return []
    def wordwrap
      Wordwrap.this(formatted_value, width: width)
    end

    private

    def formatted_value
      alignment.fetch(position, :none)
    end

    def alignment
      {
        none:  value,
        left:  value.ljust(padding, spacer),
        right: value.rjust(padding, spacer)
      }
    end

    def width
      options.align.width
    end

    def position
      options.align.pos
    end

    def padding
      options.align.pad
    end

    def spacer
      options.align.char
    end
  end
end
