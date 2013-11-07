module Trlo
  class Output
    def initialize(header, content)
      @header  = header
      @content = content
    end

    def render
      puts Hirb::Helpers::AutoTable.
        render(content, { :fields      => header.keys,
                          :headers     => header,
                          :description => false })
    end

    private
    attr_reader :header, :content
  end
end

