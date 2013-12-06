module Ctrlo
  class RefreshAll
    def initialize
    end

    def self.perform
      new.perform
    end

    def perform
      external_board_ids.map do |id|
        ExternalList.fetch(id, { mode: :board })
        ExternalCard.fetch(id, { mode: :board })
        ExternalComment.fetch(id, { mode: :board })
        ExternalMember.fetch(id, { mode: :board })
      end
      true
    end

    private

    def external_board_ids
      active_boards.map(&:external_board_id)
    end

    def active_boards
      all_boards.delete_if { |b| b.closed == true }
    end

    def all_boards
      @boards ||= ExternalBoard.refresh_all
    end
  end
end
