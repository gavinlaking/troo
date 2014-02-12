module Troo
  module API
    class Post < Request
      def request
        Net::HTTP::Post.new(uri).tap do |request|
          # request['Content-Type'] = 'application/json' needed if we're sending a body
          request.body = query
        end
      end
    end
  end
end
