module Troo
  module Decorators
    class Board < Resource
      include DecoratorHelpers

      def short
        [default, id_str, name_str].join + "\n"
      end

      def name_str
        highlight(name, options)
      end

      def description
        return 'N/A' if klass.description.nil? ||
                        klass.description.empty?
        word_wrap(klass.description)
      end

      private

      def defaults
        {
          ansicolor: true,
          colour:    Esc.blue,
          underline: Esc.underline
        }
      end
    end
  end
end
