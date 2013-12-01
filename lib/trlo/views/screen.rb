module Trlo
  class Esc
    extend Term::ANSIColor
  end

  class Screen
    def initialize(object)
      @object = object
    end

    def self.render(object)
      new(object).render
    end

    def render
      puts parse_template
    end

    private
    attr_reader :object

    def horizontal_line
      "-" * width
    end

    def label(string = nil)
      Esc.blue + Esc.underline + string + Esc.reset
    end

    def metadata(label, data)
      Esc.cyan + label.rjust(9) + Esc.reset + " " + data
    end

    def parse_template
      ERB.new(load_template, nil, "-").result(binding)
    end

    def load_template
      File.read(File.dirname(__FILE__) + object.template_file)
    end

    def width
      terminal_size[0] || 80
    end

    def height
      terminal_size[1] || 25
    end

    def terminal_size
      @terminal_size ||= Hirb::Util.detect_terminal_size
    end
  end
end
