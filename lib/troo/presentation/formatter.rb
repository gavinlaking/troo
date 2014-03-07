module Troo
  class Esc
    extend Term::ANSIColor
  end

  class Align
    include Virtus.value_object

    values do
      attribute :pos,   Symbol,  default: :none
      attribute :pad,   Integer, default: 0
      attribute :char,  String,  default: ' '
      attribute :width, Integer, default: 80
    end
  end

  class Format
    include Virtus.value_object

    values do
      attribute :ansicolor, Boolean,     default: true
      attribute :colour,    String
      attribute :underline, Boolean,     default: false
      attribute :reset,     String,      default: Esc.reset
      attribute :align,     Troo::Align, default: Troo::Align.new
    end

    def underline
      @underline ? Esc.underline : nil
    end
  end

  class Formatter
    include Virtus.model

    attribute :value,   String
    attribute :options, Troo::Format

    class << self
      def highlight(value, options = {})
        new({ value: value, options: options }).highlight
      end

      def error(value)
        new({ value:   value,
              options: { colour: Esc.red } }).error
      end

      def wordwrap(value, width = 70)
        new({ value:   value,
              options: { align: { width: width } } }).wordwrap
      end
    end

    def highlight
      [
        options.colour,
        options.underline,
        formatted_value,
        options.reset
      ].join
    end

    def error
      [
        options.colour,
        formatted_value,
        options.reset
      ].join
    end

    def wordwrap
      formatted_value
        .gsub(/\n/, ' ')
        .gsub(/(.{1,#{options.align.width}})(\s+|$)/, "\\1\n")
        .strip
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
