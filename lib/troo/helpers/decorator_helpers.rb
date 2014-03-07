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

      def error(message)
        Troo::Formatter.error(message)
      end

      def label_defaults
        {
          colour:    Esc.yellow,
          underline: true
        }
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
