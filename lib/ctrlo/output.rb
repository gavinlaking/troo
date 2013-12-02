module Ctrlo
  class Output
    def initialize(collection)
      @collection = collection
    end

    def self.render(collection)
      new(collection).render
    end

    def render
      puts Hirb::Helpers::AutoTable.
        render(content, { fields:      header.keys,
                          headers:     header,
                          description: false })
    end

    private
    attr_reader :collection

    def header
      @header ||= collection.first.header
    end

    def content
      collection.map(&:content)
    end
  end
end

