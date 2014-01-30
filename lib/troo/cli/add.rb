module Troo
  module CLI
    class Add < ThorFixes
      package_name "add"

      desc "board (<name>)",
           "Add a new board with <name>."
      def board(name = nil)
        board_name = name.nil? ? prompt_for_name : name

        say Commands::Add.dispatch(:board, board_name)
      end

      desc "card <id> (<name>)",
           "Add a new card to list <id> with <name>."
      def card(id, name = nil)
        card_name = name.nil? ? prompt_for_name : name

        say Commands::Add.dispatch(:card, card_name, id)
      end

      desc "comment <id> (<comment>)",
           "Add a new comment to card <id>."
      def comment(id, comment = nil)
        user_comment = comment.nil? ? prompt_for_comment : comment

        say Commands::Add.dispatch(:comment, user_comment, id)
      end

      desc "list <id> (<name>)",
           "Add a new list to board <id> with <name>."
      def list(id, name = nil)
        list_name = name.nil? ? prompt_for_name : name

        say Commands::Add.dispatch(:list, name, id)
      end

      private

      def prompt_for_name
        @answer = ask("Please enter a name:")
      end

      def prompt_for_comment
        @answer = ask("Please enter a comment:")
      end
    end
  end
end
