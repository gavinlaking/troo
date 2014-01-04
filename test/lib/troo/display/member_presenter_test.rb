require_relative "../../../test_helper"

module Troo
  describe MemberPresenter do
    let(:described_class) { MemberPresenter }
    let(:options) { { } }
    let(:external_member_ids) { ["5195fdb5a8c01a2318004f5d"] }

    before do
      @card = Fabricate(:card, external_member_ids: external_member_ids)
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

    describe "#render_show" do
      subject { described_class.render_show(@card, options) }

      context "when there is one member" do
        it "returns the member" do
          subject.must_equal("@gavinlaking1")
        end
      end

      context "when there are two members" do
        let(:external_member_ids) { ["5195fdb5a8c01a2318004f5d", "helium"] }

        before do
          @member_2 = Fabricate(:member, username: "helium", external_member_id: "helium")
        end

        it "returns a formatted list of members" do
          subject.must_equal("@gavinlaking1 and @helium")
        end
      end

      context "when there are many members" do
        let(:external_member_ids) { ["5195fdb5a8c01a2318004f5d", "helium", "lithium", "beryllium"] }

        before do
          @member_2 = Fabricate(:member, username: "helium", external_member_id: "helium")
          @member_3 = Fabricate(:member, username: "lithium", external_member_id: "lithium")
          @member_4 = Fabricate(:member, username: "beryllium", external_member_id: "beryllium")
        end

        it "returns a formatted list of members" do
          subject.must_equal("@gavinlaking1, @helium, @lithium and @beryllium")
        end
      end

      context "when there are no members" do
        before { @member.delete }

        it "returns a polite message" do
          subject.must_match /No members have been assigned/
        end
      end
    end
  end
end
