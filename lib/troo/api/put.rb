module Troo
  module API
    class Put < Request
      def request
        Net::HTTP::Put.new(uri).tap do |request|
          request['Accept'] = 'application/json'
          request.body = query
        end
      end
    end
  end
end
