module Trlo
  class Command
    def self.main_sequence
      new.main_sequence
    end

    def main_sequence
      loop do
        # case Input.read
        # when "quit"; end_sequence
        # when "test"; test
        # end
      end
    end

    def initialize; end

    private

    def test
      # a test method
    end

    def end_sequence
      # cleanup
    end
  end
end
