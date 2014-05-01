require_relative '../../../test_helper'

module Troo
  module Remote
    describe CommentData do
      let(:described_class)    { CommentData }
      let(:resource)           {
        {
          board: {},
          card:  {},
          text:  ''
        }
      }
      let(:described_instance) { described_class.new(resource) }

      subject { described_instance }

      it { subject.must_be_instance_of(Troo::Remote::CommentData) }
    end
  end
end
