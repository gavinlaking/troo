module Troo
  module API
    class ErrorResponse
      include Virtus.model

      attribute :body
      attribute :code
    end
  end
end
