module Troo
  module Presenters
    class Member
      include DecoratorHelpers

      # @param  [Troo::Card]
      # @param  [Hash]
      # @return [Troo::Presenters::Member]
      def initialize(card, options = {})
        @card, @options = card, options
      end

      # @return [String]
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
