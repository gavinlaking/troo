require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Member do
      let(:described_class) { Member }
      let(:options)         { {} }
      let(:member)          { Fabricate.build(:member) }

      describe '#username' do
        subject { described_class.new(member).username }

        it "returns the member's username" do
          subject.must_equal("@#{member.username}")
        end
      end

      describe '#name' do
        subject { described_class.new(member).name }

        it "returns the member's full name" do
          subject.must_equal(member.full_name)
        end
      end

      describe '#initials' do
        subject { described_class.new(member).initials }

        it "returns the member's initials" do
          subject.must_equal(member.initials)
        end
      end
    end
  end
end
