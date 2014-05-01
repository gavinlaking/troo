require_relative '../../../test_helper'

module Troo
  module Remote
    describe CommentDataCard do
      let(:described_class)    { CommentDataCard }
      let(:resource)           {
        {
          shortLink: '',
          idShort:   '',
          name:      '',
          id:        ''
        }
      }
      let(:described_instance) { described_class.new(resource) }

      subject { described_instance }

      it { subject.must_be_instance_of(Troo::Remote::CommentDataCard) }
    end
  end
end
