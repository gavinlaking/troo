module Troo
  module CLI
    class Add < Thor
      desc "board", "Add a new board with <name>"
      def board(name)
        result = Troo::CreateBoard.with(name, description = nil)
        Troo::ExternalBoard.fetch_all

        say "New board '#{result.name}' created"
      end

      desc "card <list_id>", "Add a new card to <list_id> with <name>"
      def card(list_id, name = nil, desc = nil)
        result = Troo::CreateCard.for(list_id, name)
        Troo::ExternalCard.fetch(result.external_list_id, { mode: :list, comments: false })

        say "New card '#{result.name}' created"
      end

      desc "comment <card_id>", "Add a new comment to <card_id>"
      def comment(card_id, comment = nil)
        result = Troo::CreateComment.for(card_id, comment)
        Troo::ExternalComment.fetch(result.external_card_id, { mode: :card })

        say "New comment created"
      end

      desc "list <board_id>", "Add a new list to <board_id> with <name>"
      def list(board_id, name = nil)
        result = Troo::CreateList.for(board_id, name)
        Troo::ExternalList.fetch(result.external_board_id, { mode: :board })

        say "New list '#{result.name}' created"
      end
    end
  end
end
