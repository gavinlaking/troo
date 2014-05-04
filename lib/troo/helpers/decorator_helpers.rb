module Troo
  module DecoratorHelpers
    module ClassMethods
    end

    module InstanceMethods
      private

      # @param value [String]
      # @return [String]
      def brackets(value)
        [
          '(', value, ')'
        ].join
      end

      # @param value   [String]
      # @param options [Hash]
      # @return [String]
      def label(value, options = {})
        Troo::Formatter
          .highlight(value, label_defaults.merge!(options))
      end

      # @param value [String]
      # @return [String]
      def metadata(value)
        Troo::Formatter.highlight(value, metadata_defaults)
      end

      # @param message [String]
      # @param options [Hash]
      # @return [String]
      def error(message, options = {})
        Troo::Formatter.error(message, options) + "\n"
      end

      # @return [Hash]
      def label_defaults
        {
          colour:    Esc.yellow,
          underline: true
        }
      end

      # @return [Hash]
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

      # @param resource []
      # @param options  [Hash]
      # @return []
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
