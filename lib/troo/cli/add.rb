module Troo
  module CLI
    class Add < ThorFixes
      package_name 'add'

      desc 'board (<name>)',
           'Add a new board with <name>; prompts if <name> not ' \
           'provided.'
      def board(name = nil)
        board_name = name.nil? ? prompt_for_name : name

        say Commands::Add::Board.dispatch(board_name)
      end

      desc 'card <list_id> (<name>)',
           'Add a new card to the list with <list_id> with <name>; ' \
           'prompts if <name> not provided.'
      def card(id, name = nil)
        card_name = name.nil? ? prompt_for_name : name

        say Commands::Add::Card.dispatch(card_name, id)
      end

      desc 'comment <card_id> (<comment>)',
           'Add a new comment to the card with <card_id> with ' \
           '<comment>; prompts if <comment> not provided.'
      def comment(id, comment = nil)
        comment_text = comment.nil? ? prompt_for_comment : comment

        say Commands::Add::Comment.dispatch(comment_text, id)
      end

      desc 'list <board_id> (<name>)',
           'Add a new list to the board with <board_id> with ' \
           '<name>; prompts if <name> not provided.'
      def list(id, name = nil)
        list_name = name.nil? ? prompt_for_name : name

        say Commands::Add::List.dispatch(list_name, id)
      end

      private

      def prompt_for_name
        @answer = ask('Please enter a name:')
      end

      def prompt_for_comment
        @answer = ask('Please enter a comment:')
      end
    end
  end
end
