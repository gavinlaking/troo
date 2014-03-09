require_relative '../../../../test_helper'

module Troo
  module Commands
    describe Add do
      let(:described_class) { Add }
      let(:value)           {}
      let(:id)              {}
      let(:options)         { { type: type } }
      let(:type)            { :none }
      let(:outcome)         { false }
      let(:resource)        { stub('resource', external_id: '200') }

      before do
        ['Board', 'Card', 'List'].each do |type|
          Object.const_get("Troo::#{type}").stubs(:retrieve)
            .returns(resource)
        end
        ['Board', 'Card', 'List', 'Comment'].each do |type|
          Object.const_get("Troo::Remote::Persistence::#{type}")
            .stubs(:with).returns(outcome)
        end
      end

      describe '.dispatch' do
        subject { described_class.dispatch(value, id, options) }

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

        context 'when the type is not specified' do
          it 'returns a polite message' do
            subject.must_match(/Could not create resource/)
          end
        end
      end
    end
  end
end
