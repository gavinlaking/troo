module Troo
  module External
    class List < Resource
      class << self
        def fetch(external_id, options = {})
          new(external_id, options).fetch_by_external_id.map do |resource|
            ListPersistence.for(resource) unless closed?(resource)
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
        Trello::Board.find(external_id).lists
      end

      def by_list_id
        [Trello::List.find(external_id)]
      end

      def by_card_id
        []
      end

      def by_member_id
        []
      end
    end
  end
end
