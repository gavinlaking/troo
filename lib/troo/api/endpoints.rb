module Troo
  module API
    class Endpoints
      include Virtus.value_object

      values do
        attribute :board_by_id
        attribute :boards_all
        attribute :card_by_id
        attribute :cards_by_board_id
        attribute :cards_by_list_id
        attribute :comments_by_board_id
        attribute :comments_by_card_id
        attribute :comments_by_list_id
        attribute :create_board
        attribute :create_card
        attribute :create_comment
        attribute :create_list
        attribute :list_by_id
        attribute :lists_by_board_id
        attribute :member_by_id
        attribute :members_by_board_id
        attribute :move_card_board
        attribute :move_card_list
      end

      class << self
        def load(file, version)
          new(YAML.load_file(file)[version.to_s])
        end
      end

      def interpolate!(endpoint, value = {})
        fail EndpointNotFound unless self.respond_to?(endpoint)
        send(endpoint) % value
      end
    end
  end
end
