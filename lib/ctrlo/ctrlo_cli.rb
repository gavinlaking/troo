module Ctrlo
  module Helpers
    def notify(message = nil)
      puts message
    end

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
      include Helpers

      desc "all", "Show all the boards"
      def all
        Ctrlo::Screen.render(Ctrlo::Board.retrieve_all.map { |board| Ctrlo::BoardDecorator.decorate(board) }.join)
      end

      desc "current <board_id>", "Set the current board to <board_id>"
      def current(board_id)
        board = SetCurrent.for Ctrlo::Board.retrieve(board_id)
      ensure
        notify "'#{board.name}' set to current board."
      end
    end

    class Card < Thor
      include Helpers

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
        card = SetCurrent.for Ctrlo::Card.retrieve(card_id)
      ensure
        notify "'#{card.name}' set to current card."
      end

      desc "show <card_id>", "Show a card <card_id> (includes comments)"
      def show(card_id)
        Ctrlo::Screen.render(Ctrlo::CardDecorator.decorate(Ctrlo::Card.retrieve(card_id)))
      end

      desc "comment", "Comment on a card with <card_id> <comment>"
      def comment(card_id, comment = nil)
        Ctrlo::CreateComment.for(card_id, comment)

        Ctrlo::RefreshCards.for(card_id, { mode: :card })

        Ctrlo::RefreshComments.for(card_id, { mode: :card })
      end

      desc "move", "Move a card <card_id> to list <list_id>"
      def move(card_id, list_id = nil)
        unless list_id
          Output.render(Ctrlo::Board.current.lists)
          error("Please choose a destination list. (Move a card <card_id> to list <list_id>)")
          exit 1
        end

        MoveCard.with(card_id, list_id)
      end
    end

    class List < Thor
      include Helpers

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
        list = SetCurrent.for Ctrlo::List.retrieve(list_id)
      ensure
        notify "'#{list.name}' set to current list."
      end
    end

    class Main < Thor
      include Helpers

      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      def refresh
        RefreshAll.perform
      ensure
        notify "Local data is refreshed."
      end

      desc "cleanup", "Removes all local data"
      def cleanup
        DataMapper.auto_migrate!
      ensure
        notify "Local data is removed."
      end

      desc "version", "Print the version"
      def version
        puts "ctrlo #{Ctrlo::VERSION}"
      end

      desc "board [SUBCOMMAND] <args>", "Operate on the board"
      subcommand :board, Ctrlo::CLI::Board

      desc "list [SUBCOMMAND] <args>", "Operate on the list"
      subcommand :list, Ctrlo::CLI::List

      desc "card [SUBCOMMAND] <args>", "Operate on the card"
      subcommand :card, Ctrlo::CLI::Card
    end

  end
end
