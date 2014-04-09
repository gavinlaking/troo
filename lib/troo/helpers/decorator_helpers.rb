module Troo
  module DecoratorHelpers
    module ClassMethods
    end

    module InstanceMethods
      private

      def brackets(value)
        [
          '(', value, ')'
        ].join
      end

      def label(value, options = {})
        Troo::Formatter
          .highlight(value, label_defaults.merge!(options))
      end

      def metadata(value)
        Troo::Formatter.highlight(value, metadata_defaults)
      end

      def error(message)
        Troo::Formatter.error(message) + "\n"
      end

      def label_defaults
        {
          colour:    Esc.yellow,
          underline: true
        }
      end

      def metadata_defaults
        {
          colour:    Esc.cyan,
          underline: false,
          align:     {
                       pos: :right,
                       pad: 9
                     }
        }
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
