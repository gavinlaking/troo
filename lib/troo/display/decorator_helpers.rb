module Troo
  module DecoratorHelpers
    module ClassMethods
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    def highlight(value, options = {})
      colour    = options.fetch(:colour, nil)
      underline = options.fetch(:underline, nil)
      [colour, underline, value, Esc.reset].join
    end

    def brackets(value)
      "(#{value})"
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
