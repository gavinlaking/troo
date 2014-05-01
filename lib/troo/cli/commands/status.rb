module Troo
  module Commands
    class Status
      class << self
        # @param  []
        # @return [String]
        def dispatch(klass)
          new(klass).report_status
        end
      end

      # @param  []
      # @return [Troo::Commands::Status]
      def initialize(klass)
        @klass = klass
      end

      # @return [String]
      def report_status
        return success if resource
        error
      end

      private

      attr_reader :klass

      def success
        label + plural + " found.\n" + resource_title
      end

      def error
        if count > 0
          label + no_default_error + " (#{count})"
        else
          label + "No #{type}s found.\n"
        end
      end

      def label
        "  #{type.capitalize}s:".ljust(10)
      end

      def resource_title
        ''.rjust(10) + resource.decorator.title
      end

      def no_default_error
        Esc.red + "No default #{type} set." + Esc.reset
      end

      def plural
        if count == 1
          "#{count} #{type}"
        else
          "#{count} #{type}s"
        end
      end

      def type
        klass.type.to_s
      end

      def resource
        @resource ||= klass.default
      end

      def count
        @count ||= klass.count
      end
    end
  end
end
