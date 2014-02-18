module Troo
  class CreateList
    class << self
      def with(board, name)
        new(board, name).perform
      end
    end

    def initialize(board, name)
      @board = board
      @name  = name
    end

    def perform
      create_local
    end

    private

    attr_reader :board, :name

    def create_local
      return Persistence::List.with_collection(resource) if resource
      false
    end

    def resource
      @resource ||= API::Client.perform(parameters)
    end

    def parameters
      {
        verb:          :post,
        endpoint:      :create_list,
        interpolation: {},
        query:         query,
        model:         Remote::List
      }
    end

    def query
      {
        name:     name,
        board_id: board.external_board_id
      }
    end
  end
end
