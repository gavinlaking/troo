module Troo
  module DecoratorHelpers
    module ClassMethods
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def title
      highlight([default, brackets(id), name].join(' '), options)
    end

    private

    def title_for(resource)
      indent { print resource.title + "\n" }
    end

    def word_wrap(text, line_width = 70)
      return text if line_width <= 0
      text.gsub(/\n/, ' ').gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip
    end

    def highlight(value, options = {})
      if options.fetch(:ansicolor, true)
        [options.fetch(:colour, nil),
         options.fetch(:underline, nil),
         value,
         Esc.reset].join
      else
        value
      end
    end

    def brackets(value)
      "(#{value})"
    end

    def label(string)
      highlight(string,  ansicolor: true,
                         colour:    Esc.yellow,
                         underline: Esc.underline)
    end

    def member(string)
      highlight(string,  ansicolor: true,
                         colour:    Esc.magenta,
                         underline: Esc.underline)
    end

    def metadata(label, string)
      [highlight(label.rjust(9),  ansicolor: true,
                                  colour:    Esc.cyan,
                                  underline: nil),
       string].join(' ')
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
        print [(' ' * 2), [Esc.red, message, Esc.reset].join].join(' ') + "\n"
      end
    end
  end
end
