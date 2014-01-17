module Troo
  class RefreshAll
    class << self
      def all(board = nil, options = {})
        new(board, options).all
      end

      def default(board, options = {})
        new(board, options).default
      end

      def lists(board, options = {})
        new(board, options).lists
      end

      def cards(board, options = {})
        new(board, options).cards
      end
    end

    def initialize(board = nil, options = {})
      @board = board
      @options = options
    end

    def all
      external_board_ids.map do |external_board_id|
        External::List.fetch(external_board_id, options)
        External::Member.fetch(external_board_id, options)
        External::Card.fetch(external_board_id, options)
      end
      true
    end

    def default
      new_lists = External::List.fetch(external_board_id, options)
      new_cards = new_lists.map do |list|
        External::Card.fetch(list.external_list_id, { mode: :list })
      end
      External::Member.fetch(external_board_id, options)
      true
    end

    def lists
      External::List.fetch(external_board_id, options)
    end

    def cards
      External::Card.fetch(external_board_id, options)
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
      @boards ||= External::Board.fetch_all
    end
  end
end
