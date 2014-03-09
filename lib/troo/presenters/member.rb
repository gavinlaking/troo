module Troo
  module Presenters
    class Member
      include DecoratorHelpers

      def initialize(card, options = {})
        @card, @options = card, options
      end

      def show
        Sentence.construct(members, 'members')
      end

      private

      attr_reader :card, :options

      def output
        @output ||= Troo::Output.new
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end

      def members
        @members ||= card.members.map do |member|
          member.decorator.username
        end
      end
    end
  end
end
