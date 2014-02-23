module Troo
  module Commands
    module Refresh
      class All
        def self.dispatch
          new.refresh_all
        end

        def refresh_all
          return success if refreshed?
          failure
        end

        private

        def success
          'All local data refreshed.'
        end

        def failure
          'Cannot refresh all local data.'
        end

        def refreshed?
          resources.any?
        end

        def resources
          external_board_ids.map do |id|
            Troo::Board.remote(id, mode: :board)
          end
        end

        def external_board_ids
          all_boards.map(&:id)
        end

        def all_boards
          @boards ||= Troo::Board.remote(0, mode:    :all,
                                            persist: false)
        end
      end
    end
  end
end
