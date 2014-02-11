module Troo
  module API
    class Get < Request
      def request
        Net::HTTP::Get.new(uri).tap do |request|
          request['Accept'] = 'application/json'
        end
      end
    end
  end
end
