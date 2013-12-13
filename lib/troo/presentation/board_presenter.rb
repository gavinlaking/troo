module Troo
  class BoardPresenter
    def initialize(boards, options = {})
      @boards  = boards
      @options = options
    end

    def self.render(boards, options = {})
      new(boards, options).render
    end

    def render
      boards.each do |board|
        BoardDecorator.new(board).short if show_boards?

        board.lists.each do |list|
          if show_lists?
            indent if show_boards?
            ListDecorator.new(list).short
          end

          list.cards.each do |card|
            if show_cards?
              indent if show_boards?
              indent if show_lists?
              CardDecorator.new(card).short
            end
          end
        end
      end
      nil
    end

    private

    def show_boards?; options.fetch(:show_boards); end
    def show_lists?;  options.fetch(:show_lists);  end
    def show_cards?;  options.fetch(:show_cards);  end

    def boards
      @boards.is_a?(Array) ? @boards : [@boards]
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
