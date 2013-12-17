require_relative "../../../test_helper"

module Troo
  describe MemberDecorator do
    let(:described_class) { MemberDecorator }
    let(:current) { true }

    before do
      Ohm.redis.flushall
      @member = Troo::Member.create({
        username:           "gavinlaking1",
        full_name:          "Gavin Laking",
        initials:           "GL",
        external_member_id: "5195fdb5a8c01a2318004f5d"
      })
    end

    after do
      @member.delete
    end

    describe "#initialize" do
      subject { described_class.new(@member) }

      it "assigns the member to an instance variable" do
        subject.instance_variable_get("@member").must_equal(@member)
      end
    end

    describe "#username" do
      subject { described_class.new(@member).username }

      it "returns the member's username" do
        subject.must_equal("(#{@member.username})")
      end
    end

    describe "#name" do
      subject { described_class.new(@member).name }

      it "returns the member's full name" do
        subject.must_equal(@member.full_name)
      end
    end

    describe "#initials" do
      subject { described_class.new(@member).initials }

      it "returns the member's initials" do
        subject.must_equal(@member.initials)
      end
    end
  end
end
