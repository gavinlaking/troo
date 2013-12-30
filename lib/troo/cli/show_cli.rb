module Troo
  module CLI
    class Show < ThorFixes
      package_name "show"

      desc "boards", "Show all the boards with lists."
      def boards
        boards = Troo::BoardRetrieval.retrieve
        if boards.any?
          boards.map do |board|
            BoardPresenter.render_all(board)
          end
        else
          say "Boards not found."
        end
      end

      desc "board (<board_id>)", "Show lists and cards for board <board_id> (uses current board if <board_id> not provided)."
      def board(board_id = nil)
        if board_id.nil?
          if board = Troo::BoardRetrieval.current
            BoardPresenter.render_show(board)
          else
            return say "Specify a <board_id> or use 'troo current board <board_id>' to set a current board first."
          end
        else
          if board = Troo::BoardRetrieval.retrieve(board_id)
            BoardPresenter.render_show(board)
          else
            return say "Board not found."
          end
        end
      end

      desc "list <list_id>", "Show all cards for list <list_id>."
      def list(list_id)
        if list = Troo::ListRetrieval.retrieve(list_id)
          ListPresenter.render_show(list)
        else
          say "List not found."
        end
      end

      desc "card <card_id>", "Show a card <card_id> (includes latest 3 comments)."
      def card(card_id)
        if card = Troo::CardRetrieval.retrieve(card_id)
          CardPresenter.render_show(card)
        else
          say "Card not found."
        end
      end

      desc "comments <card_id>", "Show all comments for card <card_id>."
      def comments(card_id)
        if card = Troo::CardRetrieval.retrieve(card_id)
          CommentPresenter.render_show(card)
        else
          say "Card not found."
        end
      end
    end
  end
end
