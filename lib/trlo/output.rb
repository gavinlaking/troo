module Trlo
  class Output
    def initialize(content)
      @content = content
    end

    def list_table
      puts Hirb::Helpers::AutoTable.
        render(content, { fields:      header.keys,
                          headers:     header,
                          description: false })
    end

    private
    attr_reader :content

    def header
      content.first.fetch(:header)
    end
  end
end

