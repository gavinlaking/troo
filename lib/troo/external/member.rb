module Troo
  module External
    class Member < Resource
      class << self
        def fetch(external_id, options = {})
          new(external_id, options).fetch_by_external_id.map do |resource|
            MemberPersistence.for(resource)
          end
        end
      end

      def initialize(external_id, options = {})
        @external_id = external_id
        @options     = options
      end

      private
      attr_reader :external_id

      def options
        defaults.merge!(@options)
      end

      def defaults
        { mode: :board }
      end

      def by_board_id
        Trello::Board.find(external_id).members
      end

      def by_list_id
        []
      end

      def by_card_id
        []
      end

      def by_member_id
        [Trello::Member.find(external_id)]
      end
    end
  end
end
