module Ctrlo
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
        Output.render(Ctrlo::Board.retrieve_all)
      end

      desc "current <board_id>", "Set the current board to <board_id>"
      def current(board_id)
        SetCurrent.for Ctrlo::Board.retrieve(board_id)
      end
    end

    class Card < Thor
      include CLIErrors

      desc "all", "Show all the cards for the current list or for <list_id>"
      def all(list_id = nil)
        if list_id
          Output.render(Ctrlo::List.retrieve(list_id).cards)
        else
          Output.render(Ctrlo::List.current.cards)
        end
      rescue => e
        error(e.message)
      end

      desc "current <card_id>", "Set the current card to <card_id>"
      def current(card_id)
        SetCurrent.for Ctrlo::Card.retrieve(card_id)
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Ctrlo::Screen.render(Ctrlo::CardDecorator.decorate(Ctrlo::Card.retrieve(card_id)))
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
          Output.render(Ctrlo::Board.retrieve(board_id).lists)
        else
          Output.render(Ctrlo::Board.current.lists)
        end
      rescue => e
        error(e.message)
      end

      desc "current <list_id>", "Set the current list to <list_id>"
      def current(list_id)
        SetCurrent.for Ctrlo::List.retrieve(list_id)
      end
    end

    class Main < Thor
      class_option :debug, type: :boolean, desc: "Enable debugging."

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
        puts "ctrlo #{Ctrlo::VERSION}"
      end

      desc "board [SUBCOMMAND] <args>", "Operate on the board"
      subcommand "board", Ctrlo::CLI::Board

      desc "list [SUBCOMMAND] <args>", "Operate on the list"
      subcommand "list", Ctrlo::CLI::List

      desc "card [SUBCOMMAND] <args>", "Operate on the card"
      subcommand "card", Ctrlo::CLI::Card
    end

  end
end
