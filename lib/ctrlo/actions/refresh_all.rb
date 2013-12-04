module Ctrlo
  class RefreshAll
    def self.perform
      RefreshBoards.all.map(&:external_board_id).map do |board_id|
        RefreshLists.for     board_id
        RefreshCards.for     board_id
        RefreshComments.for  board_id
        RefreshMembers.for   board_id
      end
      true
    end
  end
end
