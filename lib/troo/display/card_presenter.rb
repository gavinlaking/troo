module Troo
  class CardPresenter
    class << self
      def render_show(card, options = {})
        new(card, options).render_show
      end
    end

    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def render_show
      print Template.parse(decorated_card, "/../views/card.erb")
    end

    private
    attr_reader :card

    def decorated_card
      @decorated_card ||= CardDecorator.new(card)
    end
  end
end
