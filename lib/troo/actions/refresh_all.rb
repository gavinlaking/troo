module Troo
  class RefreshAll
    def initialize(board = nil, options = {})
      @board = board
      @options = options
    end

    def self.all(board = nil, options = {})
      new(board, options).all
    end

    def all
      external_board_ids.map do |external_board_id|
        ExternalList.fetch(external_board_id, options)
        ExternalMember.fetch(external_board_id, options)
        ExternalCard.fetch(external_board_id, options)
      end
      true
    end

    def self.default(board, options = {})
      new(board, options).default
    end

    def default
      new_lists = ExternalList.fetch(external_board_id, options)
      new_cards = new_lists.map do |list|
        ExternalCard.fetch(list.external_list_id, { mode: :list })
      end
      ExternalMember.fetch(external_board_id, options)
      true
    end

    def self.lists(board, options = {})
      new(board, options).lists
    end

    def lists
      ExternalList.fetch(external_board_id, options)
    end

    def self.cards(board, options = {})
      new(board, options).cards
    end

    def cards
      ExternalCard.fetch(external_board_id, options)
    end

    private
    attr_accessor :board

    def options
      defaults.merge!(@options)
    end

    def defaults
      { mode: :board, debug: false }
    end

    def external_board_id
      board.external_board_id
    end

    def external_board_ids
      active_boards.map(&:external_board_id)
    end

    def active_boards
      all_boards.delete_if { |b| b.nil? || b.closed == true }
    end

    def all_boards
      @boards ||= ExternalBoard.fetch_all
    end
  end
end
