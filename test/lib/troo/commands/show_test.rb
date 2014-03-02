require_relative '../../../test_helper'

module Troo
  module Commands
    describe Show do
      let(:described_class) { Show }
      let(:klass) { stub(type: 'resource_type') }
      let(:id)   {}

      let(:type) { :card }
      let(:id) { '1' }
      let(:default) { false }
      let(:resource) {}
      let(:presenter) { stub }

      before do
        API::Client.stubs(:perform)
        @card = Fabricate.build(:card, default: default)
        klass.stubs(:retrieve).returns(resource)
        Presenters::Card.stubs(:new).returns(presenter)
        presenter.stubs(:show).returns(@card.name)
      end

      after { database_cleanup }

      describe '#initialize' do
        subject { described_class.new(klass, id) }

        it 'assigns the klass to an instance variable' do
          subject.instance_variable_get('@klass').must_equal(klass)
        end

        it 'assigns the id to an instance variable' do
          subject.instance_variable_get('@id').must_equal(id)
        end
      end

      describe '.dispatch' do
        subject { described_class.dispatch(klass, id) }

        context 'when a resource ID is provided' do
          context 'and the resource exists' do
            let(:resource) { @card }

            it 'presents the cards' do
              subject.must_match(/#{@card.name}/)
            end
          end

          context 'but the resource does not exist' do
            it 'returns a polite message' do
              subject.must_match(/cannot be found/)
            end
          end
        end

        context 'when a resource ID is not provided' do
          let(:id) {}

          context 'and a default resource is set' do
            let(:default) { true }
            let(:resource) { @card }

            it 'presents the cards' do
              subject.must_match(/#{@card.name}/)
            end
          end

          context 'and a default resource is not set' do
            it 'returns a polite message' do
              subject.must_match(/to set a default/)
            end
          end
        end
      end
    end
  end
end
