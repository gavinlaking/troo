module Troo
  module CLI
    class Show < ThorFixes
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
        show(id, :board)
      end

      desc "list (<id>)", "Show all cards for list <id> (uses default list if <id> not provided)."
      def list(id = nil)
        show(id, :list)
      end

      desc "card (<id>)", "Show a card including latest 3 comments for card <id> (uses default card if <id> not provided)."
      def card(id = nil)
        show(id, :card)
      end

      desc "comments (<id>)", "Show all comments for card <id> (uses default card if <id> not provided)."
      def comments(id = nil)
        if card = CardRetrieval.retrieve(id)
          if SetDefault.for(card)
            say "'#{card.name}' set to default."
          end
          CommentPresenter.render_show(card)
        else
          if id
            say "Card cannot be found."
          else
            say "Specify a <id> or use 'troo default card <id>' to set a default card first."
          end
        end
      end

      private

      def show(id, type)
        @id, @type = id, type
        return presenter if set_default
        not_found
      end

      def set_default
        if resource
          SetDefault.for(resource)
          true
        else
          not_found_no_default
          false
        end
      end

      def presenter
        @presenter ||= case @type
        when :board    then BoardPresenter.render_show(resource)
        when :list     then ListPresenter.render_show(resource)
        when :card     then CardPresenter.render_show(resource)
        end
      end

      def resource
        @resource ||= case @type
        when :board    then BoardRetrieval.retrieve(@id)
        when :list     then ListRetrieval.retrieve(@id)
        when :card     then CardRetrieval.retrieve(@id)
        end
      end

      def not_found
        say "#{@type.to_s.capitalize} cannot be found."
      end

      def not_found_no_default
        say "Specify an <id> or use 'troo default #{@type.to_s} <id>' to set a default #{@type.to_s} first."
      end
    end
  end
end
