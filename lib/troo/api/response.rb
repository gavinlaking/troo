module Troo
  module API
    class Response
      include Virtus.model

      attribute :body, String
      attribute :code, String
    end

    class ErrorResponse < Response; end
  end
end
