require_relative "../../test_helper"

module Trlo
  describe Output do
    describe "#render" do
      let(:content) { [ { key: "1", value: "Hello", header: { key: "Key", value: "Value" } },
                        { key: "2", value: "World", header: { key: "Key", value: "Value" } } ] }
      subject { Output.new(content).render }

      it "renders a table to the screen" do
        proc { subject }.must_output <<-OUTPUT.gsub(/^ {10}/, "")
          +-----+-------+
          | Key | Value |
          +-----+-------+
          | 1   | Hello |
          | 2   | World |
          +-----+-------+
        OUTPUT
      end
    end
  end
end
