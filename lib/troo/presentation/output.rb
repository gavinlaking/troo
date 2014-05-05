module Troo
  class Output
    class << self
      def render(output)
        new(output).render
      end
    end

    def initialize(output)
      @output = output
    end

    def render
      Array(output).each { |line| print line }
      nil
    end

    private

    attr_reader :output
  end
end
