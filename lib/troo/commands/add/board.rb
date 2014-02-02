module Troo
  module Commands
    module Add
      class Board
        include CommandHelpers

        class << self
          def dispatch(value)
            new(value).add_resource
          end
        end

        def initialize(value)
          @value = value
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
        attr_reader :value

        def success
          "New board '#{created_name}' created."
        end

        def error_trello_error
          "Board could not be created."
        end

        def created_name
          created.decorator.name
        end

        def created
          @created ||= CreateBoard.with(value)
        end

        # def resource
        #   case type
        #   when :card    then ListRetrieval.retrieve(id)
        #   when :comment then CardRetrieval.retrieve(id)
        #   when :list    then BoardRetrieval.retrieve(id)
        #   else
        #   end
        # end
      end
    end
  end
end
