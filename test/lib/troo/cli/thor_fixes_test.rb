require_relative '../../../test_helper'

module Troo
  module CLI
    describe ThorFixes do
      let(:described_class) { ThorFixes }
      let(:command)         { stub(usage: 'usage') }
      let(:namespace)       {}
      let(:subcommand)      {}
      let(:package_name)    {}

      describe '.banner' do
        before do
          described_class
            .instance_variable_set('@package_name', package_name)
        end

        subject do
          described_class.banner(command, namespace, subcommand)
        end

        it { subject.must_be_instance_of(String) }

        context 'when executing a subcommand' do
          let(:package_name) { 'show' }

          it 'package_name has a leading space' do
            subject.must_match(/show usage/)
          end
        end

        context 'when executing a top-level command' do
          it 'package_name does not have a leading space' do
            subject.must_match(/\s{1}usage/)
          end
        end
      end
    end
  end
end
