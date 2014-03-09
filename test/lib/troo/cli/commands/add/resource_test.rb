require_relative '../../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Resource do
        let(:described_class) { Resource }
        let(:value)           {}
        let(:id)              {}
        let(:options)         { { type: type } }
        let(:type)            { :none }
        let(:outcome)         { false }
        let(:resource)        { stub('resource', external_id: '200') }

        before do
          Troo::Board.stubs(:retrieve).returns(resource)
          Troo::Card.stubs(:retrieve).returns(resource)
          Troo::List.stubs(:retrieve).returns(resource)
          [:board, :card, :list, :comment].each do |test_type|
            Object.const_get('Troo::Remote::Persistence::' +
              test_type.to_s.capitalize).stubs(:with).returns(outcome)
          end
        end

        describe '.dispatch' do
          subject { described_class.dispatch(value, id, options) }

          context 'when the type is specified' do
            [:board, :card, :list, :comment].each do |test_type|
              context "when the type is #{test_type}" do
                let(:type) { test_type }

                context 'when the parent resource exists' do
                  context 'and the new resource was created' do
                    let(:outcome) { true }

                    it 'returns a polite message' do
                      subject.must_match(/New/)
                    end
                  end

                  context 'and the new resource was not created' do
                    it 'returns a polite message' do
                      subject.must_match(/could not/)
                    end
                  end
                end

                context 'when the parent resource does not exist' do
                  let(:resource) {}

                  it 'returns a polite message' do
                    subject.must_match(/could not/)
                  end
                end
              end
            end
          end

          context 'when the type is not specified' do
            it 'returns a polite message' do
              subject.must_match(/Could not create resource/)
            end
          end
        end
      end
    end
  end
end
