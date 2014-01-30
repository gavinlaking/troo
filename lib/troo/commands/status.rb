module Troo
  module Commands
    class Status
      include CommandHelpers

      class << self
        def dispatch(type, id = nil)
          new(type, id).get_status
        end
      end

      def initialize(type, id = nil)
        @type, @id = type, id
      end

      def get_status
        return success if resource
        return error
      end

      private
      attr_reader :type, :id

      def resource_count
        @count = case type
        when :board then Troo::Board.count
        when :list  then Troo::List.count
        when :card  then Troo::Card.count
        end
      end

      def success
        "  #{type_capitalize}s:".ljust(10) +
        plural(resource_count, type_str)   +
        " found.\n"                        +
        "          #{resource_title}"
      end

      def error
        if resource_count > 0
          Esc.red + "  #{type_capitalize}s:  No default #{type_str} set." + Esc.reset
        else
          "  #{type_capitalize}s:".ljust(10) +
          "No #{type_str}s found.\n"
        end
      end

      def resource_title
        resource.decorator.title
      end

      def resource
        @resource = case type
        when :board then BoardRetrieval.retrieve(id)
        when :list  then ListRetrieval.retrieve(id)
        when :card  then CardRetrieval.retrieve(id)
        end
      end

      def plural(size, singular)
        case size
        when 0 then "No #{singular}s"
        when 1 then "#{size} #{singular}"
        else "#{size} #{singular}s"
        end
      end
    end
  end
end
