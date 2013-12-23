module Troo
  module DecoratorHelpers
    module ClassMethods
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    def highlight(value, options = {})
      if options.fetch(:ansicolor, true)
        [ options.fetch(:colour, nil),
          options.fetch(:underline, nil),
          value,
          Esc.reset ].join
      else
        value
      end
    end

    def brackets(value)
      "(#{value})"
    end

    def label(string)
      highlight(string, { ansicolor: true,
                          colour:    Esc.yellow,
                          underline: Esc.underline })
    end

    def metadata(label, string)
      [ highlight(label.rjust(9), { ansicolor: true,
                                    colour:    Esc.cyan,
                                    underline: nil }),
        string ].join(" ")
    end

    def spacing(options = {}, &block)
      puts if options.fetch(:head, true)
      yield
      puts if options.fetch(:foot, true)
    end

    def indent(&block)
      @indent ||= 0
      @indent += 4
      print indentation
      yield
    ensure
      @indent -= 4
    end

    def indentation
      ' ' * @indent
    end

    def print_error(message)
      indent do
        print [(" " * 2), [Esc.red, message, Esc.reset].join].join(" ") + "\n"
      end
    end
  end
end
