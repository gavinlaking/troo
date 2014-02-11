module Troo
  module API
    class Post < Request
      def request
        Net::HTTP::Post.new(uri).tap do |request|
          request['Accept'] = 'application/json'
          request.body = query
        end
      end
    end
  end
end
