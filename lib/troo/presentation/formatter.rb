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
        new(value: value, options: options).highlight
      end

      def error(value)
        new(value:   value,
            options: { colour: Esc.red }).error
      end

      def wordwrap(value, width = 70)
        new(value:   value,
            options: { align: { width: width } }).wordwrap
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

  class Wordwrap
    class << self
      def this(value, options = {})
        new(value, options).wordwrap
      end
    end

    def initialize(value, options = {})
      @value, @options = value, options
    end

    def wordwrap
      processed = []
      value.split(/\n/).map do |unprocessed|
        line_length = 0
        reformatted = []

        unprocessed.split(/\s/).map do |word|
          word_length = word.length + 1

          if (line_length += word_length) >= maximum_width
            line_length = word_length
            processed   << reformatted
            reformatted = []
          end

          reformatted << word
        end

        processed << reformatted
      end

      output(processed)
    end

    private

    attr_reader :value, :options

    def output(paragraph)
      paragraph.inject([]) do |output, line|
        output << line.join(' ')
      end.join("\n")
    end

    def maximum_width
      options.fetch(:width)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        width: 70
      }
    end
  end

  class Output
    attr_accessor :count

    def initialize
      @count = 0
    end

    def render(lines)
      Array(lines).each { |line| print indentation + line }
      nil
    end

    def indent(&block)
      @count += 1

      yield
    ensure
      @count -= 1
    end

    private

    def indentation
      ' ' * @count * 4
    end
  end
end
