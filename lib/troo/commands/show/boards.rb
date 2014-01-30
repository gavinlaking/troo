module Troo
  module Commands
    module Show
      class Boards
        include CommandHelpers

        class << self
          def dispatch
            new.render
          end
        end

        def render
          if resources.any?
            presenter
          else
            error_not_found
          end
        end

        private
        attr_reader :type, :id

        def presenter
          Presenters::Board.all(resources)
        end

        def resources
          @resource ||= BoardRetrieval.all
        end
      end
    end
  end
end
