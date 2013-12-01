module Trlo
  module CLIErrors
    def error(message = nil)
      if message
        puts message
      else
        puts "No error message was given."
      end
    end
  end

  module CLI
    class Board < Thor
      include CLIErrors

      desc "all", "Show all the boards"
      def all
        Output.render(Trlo::Board.retrieve_all)
      end

      desc "current <board_id>", "Set the current board to <board_id>"
      def current(board_id)
        SetCurrent.for Trlo::Board.retrieve(board_id)
      end
    end

    class Card < Thor
      include CLIErrors

      desc "all", "Show all the cards for the current list or for <list_id>"
      def all(list_id = nil)
        if list_id
          Output.render(Trlo::List.retrieve(list_id).cards)
        else
          Output.render(Trlo::List.current.cards)
        end
      rescue => e
        error(e.message)
      end

      desc "current <card_id>", "Set the current card to <card_id>"
      def current(card_id)
        SetCurrent.for Trlo::Card.retrieve(card_id)
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Trlo::Screen.render(Trlo::CardDecorator.decorate(Trlo::Card.retrieve(card_id)))
      end

      # option :editor
      # desc "comment", "Comment on a card with <card_id> <comment>"
      # def comment(card_id, comment = nil)
      #   CreateComment.for(list_id)
      # end

      # desc "move", "Move a card <card_id> to list <list_id>"
      # def move(card_id, list_id)
      #   MoveCard.with(card_id, list_id)
      # end
    end

    class List < Thor
      include CLIErrors

      desc "all", "Show all the lists the current board or for <board_id>"
      def all(board_id = nil)
        if board_id
          Output.render(Trlo::Board.retrieve(board_id).lists)
        else
          Output.render(Trlo::Board.current.lists)
        end
      rescue => e
        error(e.message)
      end

      desc "current <list_id>", "Set the current list to <list_id>"
      def current(list_id)
        SetCurrent.for Trlo::List.retrieve(list_id)
      end
    end

    class Main < Thor
      desc "refresh", "Refresh all data"
      def refresh
        RefreshAll.perform
      end

      desc "cleanup", "Removes all local data"
      def cleanup
        DataMapper.auto_migrate!
      end

      desc "version", "Print the version"
      def version
        puts "trlo #{Trlo::VERSION}"
      end

      desc "board [SUBCOMMAND] <args>", "Operate on the board"
      subcommand "board", Trlo::CLI::Board

      desc "list [SUBCOMMAND] <args>", "Operate on the list"
      subcommand "list", Trlo::CLI::List

      desc "card [SUBCOMMAND] <args>", "Operate on the card"
      subcommand "card", Trlo::CLI::Card
    end

  end
end
