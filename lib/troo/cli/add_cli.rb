module Troo
  module CLI
    class Add < ThorFixes
      package_name "add"

      desc "board <name> (<description>)",
           "Add a new board with <name> and optional <description>."
      def board(name = nil, description = nil)
        if name.nil?
          name = ask("Please enter a name for this board:")
        end

        if result = CreateBoard.with(name, description)
          say "New board '#{result.name}' created."
        else
          say "Board could not be created."
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end

      desc "card <list_id> <name> (<description>)",
           "Add a new card to <list_id> with <name> and optional <description>."
      def card(list_id, name = nil, description = nil)
        if name.nil?
          name = ask("Please enter a name for this card:")
        end

        if list = ListRetrieval.retrieve(list_id)
          if result = CreateCard.for(list, name, description)
            say "New card '#{result.name}' created."
          else
            say "Card could not be created."
          end
        else
          say "Card could not be created, as list was not found."
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end

      desc "comment <card_id> <comment>",
           "Add a new comment to <card_id>."
      def comment(card_id, comment = nil)
        if comment.nil?
          comment = ask("Please enter a comment:")
        end

        if card = CardRetrieval.retrieve(card_id)
          if CreateComment.for(card, comment)
            say "New comment created."
          else
            say "Comment could not be created."
          end
        else
          say "Comment could not be created, as card was not found."
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end

      desc "list <board_id> <name>",
           "Add a new list to <board_id> with <name>."
      def list(board_id, name = nil)
        if name.nil?
          name = ask("Please enter a name for this list:")
        end

        if board = BoardRetrieval.retrieve(board_id)
          if result = CreateList.for(board, name)
            say "New list '#{result.name}' created."
          else
            say "List could not be created."
          end
        else
          say "List could not be created, as board was not found."
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end
    end
  end
end
