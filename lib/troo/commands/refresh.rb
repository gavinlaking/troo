module Troo
  module Commands
    class Refresh
      include CommandHelpers

      class << self
        def dispatch(type, id = nil)
          new(type, id).refresh
        end
      end

      def initialize(type, id = nil)
        @type, @id = type, id
      end

      def refresh
        if resource.one?
          success
        elsif resource.count > 1
          many_success
        else
          error
        end
      end

      private
      attr_reader :type, :id

      def success
        "'#{resource_name}' refreshed."
      end

      def many_success
        "Multiple #{type_pluralize} refreshed."
      end

      def error
        return "Default #{type_str} cannot be found." unless id
        "#{type_capitalize} cannot be found. Specify a different <id> or use 'troo default #{type_str} <id>' to set a default #{type_str} first."
      end

      def resource_name
        resource.first.decorator.name
      end

      def resource
        return [] unless external_id

        @resource ||= case type
        when :board then External::Board.fetch(external_id)
        when :list  then External::List.fetch(external_id)
        when :card  then External::Card.fetch(external_id)
        else
        end
      end

      def external_id
        @external_id ||= case type
        when :board then BoardRetrieval.retrieve(id)
        when :list  then ListRetrieval.retrieve(id)
        when :card  then CardRetrieval.retrieve(id)
        else
        end
      end
    end
  end
end
