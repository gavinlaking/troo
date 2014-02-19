module Troo
  class CreateBoard
    class << self
      def with(name, description = nil)
        new(name, description).perform
      end
    end

    def initialize(name, description = nil)
      @name        = name
      @description = description
    end

    def perform
      create_local
    end

    private

    attr_reader :name, :description

    def create_local
      return Persistence::Board
        .with_collection(resource).first if resource
      false
    end

    def resource
      @resource ||= API::Client.perform(parameters)
    end

    def parameters
      {
        verb:          :post,
        endpoint:      :create_board,
        interpolation: {},
        query:         query,
        model:         Remote::Board
      }
    end

    def query
      {
        name: name,
        desc: description
      }
    end
  end
end
