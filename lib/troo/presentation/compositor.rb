module Troo
  class Compositor
    attr_accessor :count
    attr_accessor :output

    # @return [Troo::Compositor]
    def initialize
      @count = 0
      @output = []
    end

    # @param  [String, Array]
    # @return [Array]
    def build(content)
      Array(content).inject(output) do |out, line|
        out << (indentation + line)
      end
      output
    end

    # @return [String]
    def render
      output.flatten.join
    end

    # @return [Array]
    def spacer(&block)
      if block_given?
        output << "\n"

        block.call

        output << "\n"
      else
        output << "\n"
      end
    end

    # @return []
    def indent(&block)
      @count += 1

      yield
    ensure
      @count -= 1
    end

    private

    def indentation
      ' ' * @count * 4
    end
  end
end
