require_relative '../../../test_helper'

module Troo
  module CLI
    describe Wizard do
      let(:described_class)    { Wizard }
      let(:described_instance) { described_class.new }
      let(:exists)             { true }

      before do
        File.stubs(:exist?).returns(exists)
        File.stubs(:dirname).returns('')
        FileUtils.stubs(:cp).returns(true)
        $stdin.stubs(:gets).returns("y\n")
        Launchy.stubs(:open).returns(true)
        Dir.stubs(:home).returns('./tmp')
      end

      describe '#start' do
        subject { capture_io { described_class.new.start }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns a welcome message' do
          subject.must_match(/Welcome/)
        end

        context 'when a configuration file does not exist' do
          let(:exists) { false }

          it 'returns the "created" message' do
            subject.must_match(/file was created/)
          end
        end

        context 'when a configuration file exists' do
          it 'returns the "already exists" message' do
            subject.must_match(/already exists/)
          end
        end

        context 'when the user proceeds to step one' do
          it 'returns a thank you message' do
            subject.must_match(/Thank you/)
          end
        end

        context 'when the user proceeds to step two' do
          it 'returns a completion message' do
            subject.must_match(/All done/)
          end
        end

        context 'when the user aborts' do
          before { $stdin.stubs(:gets).returns("n\n") }

          it 'aborts the wizard' do
            proc { subject }.must_raise(Troo::ConfigurationAborted)
          end
        end
      end
    end
  end
end
