module Troo
  module CLI
    class Add < ThorFixes
      package_name "add"

      desc "board <name> (<description>)", "Add a new board with <name> and optional <description>."
      def board(name = nil, description = nil)
        if name.nil?
          name = ask("Please enter a name for this board:")
        end

        if result = Troo::CreateBoard.with(name, description)
          say "New board '#{result.name}' created."
        else
          say "Board could not be created."
        end
      end

      desc "card <list_id> <name> (<description>)", "Add a new card to <list_id> with <name> and optional <description>."
      def card(list_id, name = nil, description = nil)
        if name.nil?
          name = ask("Please enter a name for this card:")
        end

        if result = Troo::CreateCard.for(list_id, name, description)
          say "New card '#{result.name}' created."
        else
          say "Card could not be created."
        end
      end

      desc "comment <card_id> <comment>", "Add a new comment to <card_id>."
      def comment(card_id, comment = nil)
        if comment.nil?
          comment = ask("Please enter a comment:")
        end

        if Troo::CreateComment.for(card_id, comment)
          say "New comment created."
        else
          say "Comment could not be created."
        end
      end

      desc "list <board_id>", "Add a new list to <board_id> with <name>."
      def list(board_id, name = nil)
        if name.nil?
          name = ask("Please enter a name for this list:")
        end

        if result = Troo::CreateList.for(board_id, name)
          say "New list '#{result.name}' created."
        else
          say "List could not be created."
        end
      end
    end
  end
end
