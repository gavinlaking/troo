module Troo
  module Presenters
    class Member
      include DecoratorHelpers

      def initialize(card, options = {})
        @card    = card
        @options = options
      end

      def show
        Sentence.construct(members, 'members')
      end

      private

      attr_reader :card, :options

      def members
        @members ||= card.members.map do |member|
          member.decorator.username
        end
      end
    end
  end
end
