module Ctrlo
  class RefreshBoards
    def self.all
      Board.persist ExternalBoard.request
    end
  end
end
