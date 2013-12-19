module Troo
  class OverviewPresenter
    def initialize(board, options = {})
      @board   = board
      @options = options
    end

    def self.render(board, options = {})
      new(board, options).render
    end

    def render
      print BoardDecorator.new(board).short if show_boards?

      if show_lists?
        if board.lists.any?
          board.lists.each do |list|
            if show_lists?
              indent if show_boards?
              print ListDecorator.new(list).short
            end

            if list.cards.any?
              list.cards.each do |card|
                if show_cards?
                  indent if show_boards?
                  indent if show_lists?
                  print CardDecorator.new(card).short
                end
              end
            else
              indent if show_boards?
              indent if show_lists?
              print "Cards not found.\n"
            end
          end
        else
          indent if show_boards?
          print "Lists not found.\n"
        end
      end
    end

    private
    attr_reader :board

    def show_boards?
      options.fetch(:show_boards)
    end

    def show_lists?
      options.fetch(:show_lists)
    end

    def show_cards?
      options.fetch(:show_cards)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        show_boards: false,
        show_lists:  false,
        show_cards:  false
      }
    end

    def indent
      print " " * 4
    end
  end
end
