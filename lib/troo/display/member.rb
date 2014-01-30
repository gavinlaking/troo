module Troo
  class MemberPresenter
    include DecoratorHelpers

    class << self
      def show(card, options = {})
        new(card, options).show
      end
    end

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def show
      Sentence.construct(members, "members")
    end

    private
    attr_reader :card, :options

    def members
      @members ||= card.members.map do |member| member.decorator.username
      end
    end
  end
end
