module Troo
  class Compositor
    attr_accessor :count

    def initialize
      @count = 0
    end

    def render(lines)
      Array(lines).each { |line| print indentation + line }
      nil
    end

    def spacer(&block)
      if block_given?
        print "\n"
        yield
        print "\n"
      else
        print "\n"
      end
    end

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
