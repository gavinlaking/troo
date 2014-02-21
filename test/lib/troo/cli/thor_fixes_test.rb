require_relative '../../../test_helper'

module Troo
  module CLI
    describe ThorFixes do
      let(:described_class) { ThorFixes }
      let(:command)         {}
      let(:namespace)       {}
      let(:subcommand)      {}

      describe '.banner' do
        subject do
          described_class.banner(command, namespace, subcommand)
        end

        context 'when executing a top-level command' do
          it 'package_name does not have a leading space' do
            skip('Needs a spec, please write one.')
          end
        end

        context 'when executing a subcommand' do
          it 'package_name has a leading space' do
            skip('Needs a spec, please write one.')
          end
        end
      end
    end
  end
end