module Troo
  module CLI
    class List < Thor
      include Troo::Helpers

      desc "all <board_id>", "Show all the lists for board <board_id>"
      def all(board_id)
        Troo::CLI::Board.new.lists(board_id)
      end

      desc "show <list_id>", "Show all cards for list <list_id>"
      def show(list_id)
        if list_id.nil?
          raise Trello::Error
        else
          puts Troo::ListPresenter.render(
                 Troo::ListRetrieval.retrieve(list_id), { show_lists:  true,
                                                           show_cards:  true })
        end
      rescue Trello::Error
        puts "List cannot be found."
      end
    end
  end
end
