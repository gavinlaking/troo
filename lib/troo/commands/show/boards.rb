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
          return presenter if resources.any?
          error
        end

        private

        def type
          'boards'
        end

        def presenter
          Presenters::Board.all(resources)
        end

        def resources
          @resources ||= Retrieval::Board.all
        end
      end
    end
  end
end
