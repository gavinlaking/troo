module Troo
  class Response
    attr_accessor :status, :body

    def initialize(api_response)
      @api_response = api_response
    end

    def status
      @status ||= api_response.code.to_i
    end

    def body
      @body ||= Yajl::Parser.parse(api_response.body)
    end

    private

    attr_reader :api_response
  end
end
