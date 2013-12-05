module Ctrlo
  class RefreshAll
    def initialize
    end

    def self.perform
      new.perform
    end

    def perform
      external_board_ids.map do |id|
        RefreshLists.for         id
        RefreshCards.for         id
        RefreshComments.for      id
        RefreshMembers.for       id
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
      @boards ||= RefreshBoards.all
    end
  end
end
