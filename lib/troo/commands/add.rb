module Troo
  module Commands
    class Add
      include CommandHelpers

      class << self
        def dispatch(type, value, id = nil)
          new(type, value, id).add_resource
        end
      end

      def initialize(type, value, id = nil)
        @type, @value, @id = type, value, id
      end

      def add_resource
        if created
          success
        elsif created == false
          error_trello_error
        elsif no_default? && type != :board
          error_no_default
        else
          error_not_found
        end
      end

      private
      attr_reader :type, :id, :value

      def success
        "New #{type_str} #{created_name}created."
      end

      def error_trello_error
        "#{type_capitalize} could not be created."
      end

      def created_name
        return "" if type == :comment
        "'#{created.decorator.name}' "
      end

      def created
        @created ||= case type
        when :board   then CreateBoard.with(value)
        when :card    then CreateCard.for(resource, value)
        when :comment then CreateComment.for(resource, value)
        when :list    then CreateList.for(resource, value)
        else
        end
      end

      def resource
        case type
        when :card    then ListRetrieval.retrieve(id)
        when :comment then CardRetrieval.retrieve(id)
        when :list    then BoardRetrieval.retrieve(id)
        else
        end
      end
    end
  end
end
