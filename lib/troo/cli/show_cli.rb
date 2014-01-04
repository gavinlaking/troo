module Troo
  module CLI
    class Show < ThorFixes
      package_name "show"

      desc "boards", "Show all the boards with lists."
      def boards
        boards = Troo::BoardRetrieval.all
        if boards.any?
          boards.map do |board|
            BoardPresenter.render_all(board)
          end
        else
          say "Boards not found."
        end
      end

      desc "board (<board_id>)", "Show lists and cards for board <board_id> (uses default board if <board_id> not provided)."
      def board(board_id = nil)
        if board = Troo::BoardRetrieval.retrieve(board_id)
          if SetDefault.for(board)
            say "'#{board.name}' set to default."
          end
          BoardPresenter.render_show(board)
        else
          if board_id
            say "Board not found."
          else
            say "Specify a <board_id> or use 'troo default board <board_id>' to set a default board first."
          end
        end
      end

      desc "list (<list_id>)", "Show all cards for list <list_id> (uses default list if <list_id> not provided)."
      def list(list_id = nil)
        if list = Troo::ListRetrieval.retrieve(list_id)
          if SetDefault.for(list)
            say "'#{list.name}' set to default."
          end
          ListPresenter.render_show(list)
        else
          if list_id
            say "List not found."
          else
            say "Specify a <list_id> or use 'troo default list <list_id>' to set a default list first."
          end
        end
      end

      desc "card (<card_id>)", "Show a card including latest 3 comments for card <card_id> (uses default card if <card_id> not provided)."
      def card(card_id = nil)
        if card = Troo::CardRetrieval.retrieve(card_id)
          if SetDefault.for(card)
            say "'#{card.name}' set to default."
          end
          CardPresenter.render_show(card)
        else
          if card_id
            say "Card not found."
          else
            say "Specify a <card_id> or use 'troo default card <card_id>' to set a default card first."
          end
        end
      end

      desc "comments (<card_id>)", "Show all comments for card <card_id> (uses default card if <card_id> not provided)."
      def comments(card_id = nil)
        if card = Troo::CardRetrieval.retrieve(card_id)
          if SetDefault.for(card)
            say "'#{card.name}' set to default."
          end
          CommentPresenter.render_show(card)
        else
          if card_id
            say "Card not found."
          else
            say "Specify a <card_id> or use 'troo default card <card_id>' to set a default card first."
          end
        end
      end
    end
  end
end
