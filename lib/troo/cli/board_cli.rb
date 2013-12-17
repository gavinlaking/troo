module Troo
  module CLI
    class Board < Thor
      include Troo::Helpers

      desc "all", "Show all the boards"
      def all
        boards = Troo::BoardRetrieval.retrieve || []
        if boards.any?
          puts Troo::BoardPresenter.render(
                 Troo::BoardRetrieval.retrieve, { show_boards: true })
        else
          puts "No boards found."
        end
      end

      desc "show <board_id>", "Show all the lists and cards for board <board_id>"
      def show(board_id)
        if board_id.nil?
          raise Trello::Error
        else
          puts Troo::BoardPresenter.render(
                 Troo::BoardRetrieval.retrieve(board_id), { show_boards: true,
                                                            show_lists:  true,
                                                            show_cards:  true })
        end
      rescue Trello::Error
        puts "Board cannot be found."
      end
    end
  end
end
