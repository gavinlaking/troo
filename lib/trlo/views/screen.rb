module Trlo
  class Esc
    extend Term::ANSIColor
  end

  class Screen
    def initialize
      list = OpenStruct.new(name: "Totally Cool List")
      members = [:a, :b]
      comments = []

      desc = [
        Esc.red     + "Some string" + Esc.reset + "\n",
        Esc.green   + "Some string" + Esc.reset + "\n",
        Esc.yellow  + "Some string" + Esc.reset + "\n",
        Esc.blue    + "Some string" + Esc.reset + "\n",
        Esc.magenta + "Some string" + Esc.reset + "\n",
        Esc.cyan    + "Some string" + Esc.reset + "\n",
        Esc.white   + "Some string" + Esc.reset + "\n"].join

      name = "Some cool card you just wanna do..."

      @object = OpenStruct.new(id: 217,
                               name: name,
                               board: "Live Support (5)",
                               list: "Development (3)",
                               members: members,
                               comments: comments,
                               date: Time.now,
                               desc: desc)
    end

    def render
      puts parse_template
    end

    def horizontal_line
      "-" * width
    end

    def label(string = nil)
      Esc.blue + Esc.underline + string + Esc.reset
    end

    def title(id = nil, string = nil)
      [Esc.green + "(" + id.to_s + ")" + Esc.reset + " ",
       Esc.yellow + string + Esc.reset].join
    end

    private

    def parse_template
      ERB.new(load_template, nil, "-").result(binding)
    end

    def load_template
      File.read(File.dirname(__FILE__) + "/show_card.erb")
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
