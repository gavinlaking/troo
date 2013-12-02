module Trlo
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

  class RefreshBoards
    def self.all
      Board.persist ExternalBoard.request
    end
  end

  class RefreshLists
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).refresh
    end

    def refresh
      List.persist ExternalList.request(board_id)
    end

    private
    attr_reader :board_id
  end

  class RefreshCards
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).refresh
    end

    def refresh
      Card.persist ExternalCard.request(board_id)
    end

    private
    attr_reader :board_id
  end

  class RefreshComments
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).refresh
    end

    def refresh
      Comment.persist ExternalComment.request(board_id)
    end

    private
    attr_reader :board_id
  end

  class RefreshMembers
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).refresh
    end

    def refresh
      Member.persist ExternalMember.request(board_id)
    end

    private
    attr_reader :board_id
  end
end
