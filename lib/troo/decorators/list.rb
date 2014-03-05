module Troo
  module Decorators
    class List < Resource
      include DecoratorHelpers

      def short
        [default, id_str, name_str].join + "\n"
      end

      def name_str
        highlight(name, options)
      end

      private

      def defaults
        {
          ansicolor: true,
          colour:    Esc.green,
          underline: Esc.underline
        }
      end
    end
  end
end
