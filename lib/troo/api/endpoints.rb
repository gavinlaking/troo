module Troo
  module API
    class Endpoints
      class << self
        # @param  endpoints [Symbol]
        # @param  value     [Hash]
        # @return [String, EndpointNotFound]
        def interpolate(endpoint, value = {})
          new(endpoint, value).interpolate
        end
      end

      # @param  endpoint [Symbol]
      # @param  value    [Hash]
      # @return [Troo::API::Endpoints]
      def initialize(endpoint, value = {})
        @endpoint, @value = endpoint, value
      end

      # @return [String, EndpointNotFound]
      def interpolate
        endpoints.fetch(endpoint) % value
      rescue KeyError
        fail EndpointNotFound
      end

      private

      attr_reader :endpoint, :value

      def endpoints
        {
          boards_all:           '/members/me/boards',
          board_by_id:          '/boards/%{external_id}',
          card_by_id:           '/cards/%{external_id}',
          list_by_id:           '/lists/%{external_id}',
          member_by_id:         '/members/%{external_id}',
          cards_by_board_id:    '/boards/%{external_id}/cards',
          cards_by_list_id:     '/lists/%{external_id}/cards',
          comments_by_board_id: '/boards/%{external_id}/actions',
          comments_by_card_id:  '/cards/%{external_id}/actions',
          comments_by_list_id:  '/lists/%{external_id}/actions',
          lists_by_board_id:    '/boards/%{external_id}/lists',
          members_by_board_id:  '/boards/%{external_id}/members',
          create_board:         '/boards',
          create_card:          '/cards',
          create_comment:       '/cards/%{external_id}/actions/comments',
          create_list:          '/lists',
          move_card_list:       '/cards/%{external_id}/idList',
          move_card_board:      '/cards/%{external_id}/idBoard',
        }
      end
    end
  end
end
