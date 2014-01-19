module Troo
  module CLI
    class Show < ThorFixes
      include Helpers

      package_name "show"

      desc "boards", "Show all the boards with lists."
      def boards
        boards = BoardRetrieval.all
        if boards.any?
          boards.map do |board|
            BoardPresenter.render_all(board)
          end
        else
          say "Boards not found."
        end
      end

      desc "board (<id>)", "Show lists and cards for board <id> (uses default board if <id> not provided)."
      def board(id = nil)
        initialize_and_dispatch(id, :board)
      end

      desc "list (<id>)", "Show all cards for list <id> (uses default list if <id> not provided)."
      def list(id = nil)
        initialize_and_dispatch(id, :list)
      end

      desc "card (<id>)", "Show a card including latest 3 comments for card <id> (uses default card if <id> not provided)."
      def card(id = nil)
        initialize_and_dispatch(id, :card)
      end

      desc "comments (<id>)", "Show all comments for card <id> (uses default card if <id> not provided)."
      def comments(id = nil)
        if card = CardRetrieval.retrieve(id)
          if SetDefault.for(card)
            say "'#{card.decorator.name}' set to default."
          end
          CommentPresenter.show(card)
        else
          if id
            say "Card cannot be found."
          else
            say "Specify a <id> or use 'troo default card <id>' to set a default card first."
          end
        end
      end

      private
      attr_reader :id, :type

      def initialize_and_dispatch(id, type)
        @id, @type = id, type
        show_resource
      end

      def show_resource
        resource.presenter.show if set_default
      end
    end
  end
end
