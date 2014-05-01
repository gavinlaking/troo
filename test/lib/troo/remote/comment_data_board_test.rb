require_relative '../../../test_helper'

module Troo
  module Remote
    describe CommentDataBoard do
      let(:described_class) { CommentDataBoard }
      let(:resource)        {
        {
          shortLink: '',
          name:      '',
          id:        ''
        }
      }
      let(:described_instance) { described_class.new(resource) }

      subject { described_instance }

      it { subject.must_be_instance_of(Troo::Remote::CommentDataBoard) }
    end
  end
end
