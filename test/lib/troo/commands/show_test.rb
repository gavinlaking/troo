require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    module Commands
      describe Show do
        let(:described_class) { Show }
        let(:type)  { :board }
        let(:id)    { nil }

        describe "#initialize" do
          subject { described_class.new(type, id) }

          it "assigns the type to an instance variable" do
            subject.instance_variable_get("@type").must_equal(type)
          end

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(type, id) }

          it "will be tested by the integration tests" do
            skip
          end
        end
      end
    end
  end
end
