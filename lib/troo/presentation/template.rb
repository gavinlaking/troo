module Troo
  class Template
    include DecoratorHelpers

    class << self
      # @param  []
      # @param  []
      # @return []
      def parse(object, path)
        new(object, path).parse
      end
    end

    # @param  []
    # @param  []
    # @return []
    def initialize(object, path)
      @object, @path = object, path
    end

    # @return []
    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    private

    attr_reader :object, :path

    def load
      File.read(File.dirname(__FILE__) + path)
    end
  end
end
