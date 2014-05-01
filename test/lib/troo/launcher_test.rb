require_relative '../../test_helper'

module Troo
  describe Launcher do
    let(:described_class) { Launcher }
    let(:instance)        {
      described_class.new(argv, stdin, stdout, stderr, kernel)
    }
    let(:argv)            { [] }
    let(:stdin)           { STDIN }
    let(:stdout)          { STDOUT }
    let(:stderr)          { STDERR }
    let(:kernel)          { Kernel }

    it { instance.must_be_instance_of(Troo::Launcher) }

    describe '#execute!' do
      subject { instance.execute! }

      it { skip }
    end
  end
end
