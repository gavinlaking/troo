module Troo
  module Commands
    module Show
      class Boards < Resource
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

        def presenter
          Presenters::Board.all(resources)
        end

        def resources
          @resource ||= Retrieval::Board.all
        end
      end
    end
  end
end
