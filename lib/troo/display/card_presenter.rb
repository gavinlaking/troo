module Troo
  class CardPresenter
    class << self
      def show(card, options = {})
        new(card, options).show
      end
    end

    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def show
      print Template.parse(decorated_card, "/../views/card.erb")
    end

    private
    attr_reader :card

    def decorated_card
      @decorated_card ||= card.decorator
    end
  end
end
