module Troo
  class CardPresenter
    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def self.render_show(card, options = {})
      new(card, options).render_show
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
