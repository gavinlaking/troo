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

      def error(message, options = {})
        Troo::Formatter.error(message, options) + "\n"
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

      def list_view(resource, options = {})
        Presenters::Resource.list_view(resource, options)
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
