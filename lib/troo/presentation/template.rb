module Troo
  class Esc
    extend Term::ANSIColor
  end

  class Template
    include DecoratorHelpers

    class << self
      def parse(object, template_path)
        new(object, template_path).parse
      end
    end

    def initialize(object, template_path)
      @object        = object
      @template_path = template_path
    end

    def parse
      ERB.new(load_template, nil, '-').result(binding)
    end

    private
    attr_reader :object, :template_path

    def load_template
      File.read(File.dirname(__FILE__) + template_path)
    end
  end
end
