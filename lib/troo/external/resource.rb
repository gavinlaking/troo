module Troo
  module External
    class Resource
      class << self
        private

        def closed?(resource)
          resource.nil? || resource.closed?
        end
      end

      def fetch_by_external_id
        case options.fetch(:mode)
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
    end
  end
end

