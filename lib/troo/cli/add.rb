module Troo
  module CLI
    class Add < ThorFixes
      package_name 'add'

      # @param  [String]
      # @return [String]
      desc 'board (<name>)',
           'Add a new board with <name>; prompts if <name> not ' \
           'provided.'
      def board(name = nil)
        value = name.nil? ? prompt_for_name : name
        say Commands::Add.dispatch(value, nil, type: :board)
      end

      # @param  [String]
      # @param  [String]
      # @return [String]
      desc 'card <list_id> (<name>)',
           'Add a new card to the list with <list_id> with <name>; ' \
           'prompts if <name> not provided.'
      def card(id, name = nil)
        value = name.nil? ? prompt_for_name : name
        say Commands::Add.dispatch(value, id, type: :card)
      end

      # @param  [String]
      # @param  [String]
      # @return [String]
      desc 'comment <card_id> (<comment>)',
           'Add a new comment to the card with <card_id> with ' \
           '<comment>; prompts if <comment> not provided.'
      def comment(id, comment = nil)
        value = comment.nil? ? prompt_for_comment : comment
        say Commands::Add.dispatch(value, id, type: :comment)
      end

      # @param  [String]
      # @param  [String]
      # @return [String]
      desc 'list <board_id> (<name>)',
           'Add a new list to the board with <board_id> with ' \
           '<name>; prompts if <name> not provided.'
      def list(id, name = nil)
        value = name.nil? ? prompt_for_name : name
        say Commands::Add.dispatch(value, id, type: :list)
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
