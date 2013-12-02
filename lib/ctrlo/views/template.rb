module Ctrlo
  class Esc
    extend Term::ANSIColor
  end

  class Template
    def initialize(object)
      @object = object
    end

    def self.parse(object)
      new(object).parse
    end

    def parse
      ERB.new(load, nil, "-").result(binding)
    end

    def load
      File.read(File.dirname(__FILE__) + object.template_file)
    end

    private
    attr_reader :object

    def half_horizontal_line
      "-" * (width / 2).floor
    end

    def horizontal_line
      "-" * width
    end

    def label(string = nil)
      Esc.blue + Esc.underline + string + Esc.reset
    end

    def member(string = nil)
      Esc.red + string + Esc.reset
    end

    def metadata(label, data)
      Esc.cyan + label.rjust(9) + Esc.reset + " " + data
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
