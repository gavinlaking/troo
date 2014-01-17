require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe ThorFixes do
      let(:described_class) { ThorFixes }

      describe ".banner" do
        let(:command) { OpenStruct.new(usage: "some usage") }

        before  { File.stubs(:basename).returns("troo") }
        subject { described_class.banner(command) }

        it "should override Thor to provide proper subcommand help" do
          subject.must_equal("troo  some usage")
        end
      end
    end
  end
end
