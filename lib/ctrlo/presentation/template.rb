module Ctrlo
  class Esc
    extend Term::ANSIColor
  end

  class Template
    def initialize(object, template_file)
      @object        = object
      @template_file = template_file
    end

    def self.parse(object, template_file)
      new(object, template_file).parse
    end

    def parse
      ERB.new(load, nil, "-").result(binding)
    end

    def load
      File.read(File.dirname(__FILE__) + template_file)
    end

    private
    attr_reader :object, :template_file

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
      terminal_size[0]
    end

    def height
      terminal_size[1]
    end

    def terminal_size
      @terminal_size ||= if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
        [ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
      elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exists?('tput')
        [`tput cols`.to_i, `tput lines`.to_i]
      elsif STDIN.tty? && command_exists?('stty')
        `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
      else
        [80, 25]
      end
    rescue
      [80, 25]
    end

  end
end
