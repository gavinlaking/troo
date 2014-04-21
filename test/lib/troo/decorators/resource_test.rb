require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Resource do
      let(:described_class)    { Resource }
      let(:klass)              {
        stub(id:          67,
             name:        resource_name,
             description: description,
             member:      member,
             text:        'Some text...',
             date:        'Wed, Dec 17 at 22:01',
             type:        :resource_type,
             username:    'gavinlaking1')
      }
      let(:options)            { {} }
      let(:described_instance) { described_class.new(klass, options) }
      let(:resource_name)      { 'My Resource' }
      let(:description)        { 'Some description' }
      let(:member)             { stub(username: 'gavinlaking1') }
      let(:default)            { true }

      before do
        klass.stubs(:default?).returns(default)
        klass.stubs(:type).returns(:resource_type)
      end

      describe '#title' do
        subject { described_instance.title }

        it { subject.must_be_instance_of(String) }

        it { subject.must_match(/My Resource/) }
      end

      describe '#resource_title' do
        subject { described_instance.resource_title }

        it { subject.must_be_instance_of(String) }
      end

      describe '#resource_id' do
        subject { described_instance.resource_id }

        it { subject.must_be_instance_of(String) }
      end

      describe '#id' do
        subject { described_instance.id }

        it { subject.must_be_instance_of(Fixnum) }
      end

      describe '#description' do
        subject { described_instance.description }

        it { subject.must_be_instance_of(String) }

        context 'when a description exists' do
          it 'returns the description' do
            subject.must_equal(klass.description)
          end
        end

        context 'when a description does not exist' do
          before { klass.stubs(:description) }

          it 'returns N/A' do
            subject.must_equal('N/A')
          end
        end
      end

      describe '#default' do
        subject { described_instance.default }

        context 'when the resource is default' do
          it { subject.must_be_instance_of(String) }

          it 'returns a marker' do
            subject.must_equal('*')
          end
        end

        context 'when the resource is not the default' do
          let(:default) { false }

          it { subject.must_be_instance_of(NilClass) }

          it 'returns nil so that join compacts the value away' do
            subject.must_equal nil
          end
        end
      end

      describe '#name' do
        subject { described_instance.name }

        it { subject.must_be_instance_of(String) }

        context 'when the resource has a name' do
          let(:resource_name) { 'My Resource' }

          it { subject.must_equal('My Resource') }
        end

        context 'when the resource has a end of line character' do
          let(:resource_name) { "My Resource\n" }

          it { subject.must_equal('My Resource') }
        end

        context 'when the resource does not have a name' do
          let(:resource_name) {}

          it { subject.must_equal('N/A') }
        end
      end

      # describe '#board' do
      #   subject { described_instance.board }

      #   it { subject.must_be_instance_of(String) }
      # end

      # describe '#list' do
      #   subject { described_instance.list }

      #   it { subject.must_be_instance_of(String) }
      # end

      # describe '#comments' do
      #   subject { described_instance.comments }

      #   it { subject.must_be_instance_of(String) }
      # end

      # describe '#members' do
      #   subject { described_instance.members }

      #   it { subject.must_be_instance_of(String) }
      # end

      # describe '#last_activity_date' do
      #   subject { described_instance.last_activity_date }

      #   it { subject.must_be_instance_of(String) }
      # end

      describe '#as_view' do
        before { Template.stubs(:parse).returns('some output') }

        subject { described_instance.as_view }

        it { subject.must_be_instance_of(String) }

        it 'returns the rendered content' do
          subject.must_match(/some output/)
        end
      end

      describe '#username' do
        subject { described_instance.username }

        it { subject.must_be_instance_of(String) }

        it 'returns the comment member username' do
          subject.must_equal('@' + klass.member.username)
        end
      end

      describe '#text' do
        subject { described_instance.text }

        it { subject.must_be_instance_of(String) }

        it 'returns the comment text' do
          subject.must_equal(klass.text)
        end
      end

      describe '#date' do
        subject { described_instance.date }

        it { subject.must_be_instance_of(String) }

        it 'returns the comment date' do
          subject.must_equal(klass.date)
        end
      end
    end
  end
end
