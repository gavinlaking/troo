module Troo
  module External
    class Resource
      attr_reader :external_id

      class << self
        def fetch(external_id, options = {})
          new(external_id, options).persist
        end
      end

      def initialize(external_id, options = {})
        @external_id = external_id
        @options     = options
      end

      def fetch
        case options.fetch(:mode)
        when :all    then all_boards
        when :board  then by_board_id
        when :list   then by_list_id
        when :card   then by_card_id
        when :member then by_member_id
        end
      rescue Trello::InvalidAccessToken
        raise Troo::InvalidAccessToken
      rescue Trello::Error
        []
      end

      private

      def options
        defaults.merge!(@options)
      end

      def defaults
        { mode: :board }
      end
    end
  end
end
