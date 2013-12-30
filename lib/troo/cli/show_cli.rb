module Troo
  module CLI
    class Show < ThorFixes
      package_name "show"

      desc "board (<board_id>)", "Show all the boards with lists, or show lists and cards for board <board_id>."
      def board(board_id = nil)
        return Troo::CLI::Board.new.all unless board_id

        @board_id = board_id
        if retrieved_board
          BoardPresenter.render_show(retrieved_board)
        else
          say "Board not found."
        end
      end

      desc "list <list_id>", "Show all cards for list <list_id>."
      def list(list_id)
        @list_id = list_id
        if retrieved_list
          ListPresenter.render_show(retrieved_list)
        else
          say "List not found."
        end
      end

      desc "card <card_id>", "Show a card <card_id> (includes latest 3 comments)."
      def card(card_id)
        @card_id = card_id
        if retrieved_card
          CardPresenter.render_show(retrieved_card)
        else
          say "Card not found."
        end
      end

      desc "comments <card_id>", "Show all comments for card <card_id>."
      def comments(card_id)
        @card_id = card_id
        if retrieved_card
          CommentPresenter.render_show(retrieved_card)
        else
          say "Card not found."
        end
      end

      private
      attr_reader :board_id, :list_id, :card_id

      def retrieved_board
        @board ||= Troo::BoardRetrieval.retrieve(board_id)
      end

      def retrieved_list
        @list ||= Troo::ListRetrieval.retrieve(list_id)
      end

      def retrieved_card
        @card ||= Troo::CardRetrieval.retrieve(card_id)
      end
    end
  end
end
