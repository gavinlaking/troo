module Troo
  module Remote
    class Resource
      def self.create(json)
        new(json).create
      end

      def initialize(json)
        @json = json
      end

      def create
        self
      end

      private
      attr_reader :json

      def params
        @params ||= JSON.parse(json)
      end
    end
  end
end
