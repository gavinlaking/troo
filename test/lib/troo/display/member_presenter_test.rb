require_relative "../../../test_helper"

module Troo
  describe MemberPresenter do
    let(:described_class) { MemberPresenter }
    let(:options)         { { } }

    before do
      @card = Fabricate(:card, external_member_ids: ["5195fdb5a8c01a2318004f5d"])
      @member = Fabricate(:member)
    end

    after { database_cleanup }

    describe "#initialize" do
      subject { described_class.new(@card, options) }

      it "assigns the card to an instance variable" do
        subject.instance_variable_get("@card").must_equal(@card)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#show" do
      subject { described_class.show(@card, options) }

      it "returns the members as a sentence" do
        subject.must_equal("@gavinlaking1")
      end
    end
  end
end
