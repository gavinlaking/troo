module Troo
  class Output
    class << self
      # @param output []
      # @return [NilClass]
      def render(output)
        new(output).render
      end
    end

    # @param output []
    # @return [Troo::Output]
    def initialize(output)
      @output = output
    end

    # @return [NilClass]
    def render
      Array(output).each { |line| print line }
      nil
    end

    private

    attr_reader :output
  end
end
