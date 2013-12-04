module Ctrlo
  class RefreshLists
    def initialize(board_id, options = {})
      @board_id = board_id
      @options  = options
    end

    def self.for(board_id, options = {})
      new(board_id, options).refresh
    end

    def refresh
      List.persist ExternalList.request(board_id)
    end

    private
    attr_reader :board_id
  end
end
