require_relative '../../../test_helper'

module Troo
  module Retrieval
    describe Local do
      let(:described_class)  { Local }
      let(:klass)            { stub(type: type) }
      let(:id)               {}
      let(:options)          { {} }
      let(:type)             { :resource_type }
      let(:default_board)    {}
      let(:local_resource)   {}
      let(:remote_resource)  { [] }
      let(:default_resource) {}
      let(:count)            { 2 }

      before do
        Troo::Board.stubs(:default).returns(default_board)
        klass.stubs(:remote).returns(stub)
        klass.stubs(:default).returns(default_resource)
        klass.stubs(:first).returns(local_resource)
        klass.stubs(:[]).returns(local_resource)
        klass.stubs(:by_external_id).returns(local_resource)
        Retrieval::Remote.stubs(:fetch).returns(remote_resource)
        klass.stubs(:count).returns(count)
      end

      describe '.all' do
        let(:collection) { [:resource, :resource] }

        before { klass.stubs(:all).returns(collection) }

        subject { described_class.all(klass) }

        it { subject.must_be_instance_of(Array) }

        context 'when local resources exist' do
          it 'returns all the local resources' do
            subject.must_equal(collection)
          end
        end

        context 'when no local resources exist' do
          let(:collection) { [] }

          it 'returns an empty collection' do
            subject.must_equal []
          end
        end
      end

      describe '.default' do
        subject { described_class.default(klass, options) }

        it { subject.must_be_instance_of(NilClass) }

        context 'when the default is set' do
          let(:default_resource) { stub }

          it 'returns the resource marked as default' do
            subject.wont_equal nil
          end
        end

        context 'when the default is not set' do
          it { subject.must_equal nil }
        end
      end

      describe '.retrieve' do
        subject { described_class.retrieve(klass, id, options) }

        it { subject.must_be_instance_of(NilClass) }

        context 'without an ID' do
          context 'when the default is set' do
            let(:default_resource) { stub }

            it 'returns the resource marked as default' do
              subject.wont_equal nil
            end
          end

          context 'when the default is not set' do
            it { subject.must_equal nil }
          end
        end

        context 'with an ID' do
          let(:id) { 67 }

          context 'attempts local retrieval by short_id' do
            context 'when the resource type is not a card' do
              context 'when the resource exists' do
                let(:local_resource) { stub }

                it 'returns the resource' do
                  subject.must_equal(local_resource)
                end
              end

              context 'when the resource does not exist' do
                it { subject.must_equal nil }
              end
            end

            context 'when the resource type is a card' do
              let(:type) { :card }

              context 'and a default board exists' do
                let(:default_board) { stub(external_id: 27) }

                context 'and more than 1 with this short_id' do
                  let(:local_resource) { stub }

                  it 'use the default board to return the correct ' \
                     'resource' do
                    subject.must_equal(local_resource)
                  end
                end

                context 'and 0 or 1 of this resource exists' do
                  let(:count)          { 1 }
                  let(:local_resource) { stub }

                  it 'returns the resource' do
                    subject.must_equal(local_resource)
                  end
                end

                context 'but the resource does not exist' do
                  it { subject.must_equal nil }
                end
              end

              context 'and no default board exists' do
                context 'and the resource exists' do
                  let(:local_resource) { stub }

                  it 'returns the resource' do
                    subject.must_equal(local_resource)
                  end
                end

                context 'and the resource does not exist' do
                  it { subject.must_equal nil }
                end
              end
            end
          end

          context 'attempts local retrieval by database ID' do
            context 'when the resource exists' do
              let(:local_resource) { stub }

              it 'returns the resource' do
                subject.must_equal(local_resource)
              end
            end

            context 'when the resource does not exist' do
              it { subject.must_equal nil }
            end
          end

          context 'attempts local retrieval by external ID' do
            context 'when the resource exists' do
              let(:local_resource) { stub }

              it 'returns the resource' do
                subject.must_equal(local_resource)
              end
            end

            context 'when the resource does not exist' do
              it { subject.must_equal nil }
            end
          end

          context 'when remote access is allowed' do
            context 'attempts remote retrieval by ID' do
              context 'when the resource exists' do
                let(:resource)        { stub }
                let(:remote_resource) { [resource] }

                it 'returns the resource' do
                  subject.must_equal(resource)
                end
              end

              context 'when the resource does not exist' do
                it { subject.must_equal nil }
              end
            end
          end

          context 'when remote access is not allowed' do
            let(:options) { { allow_remote: false } }

            it { subject.must_equal nil }
          end

          context 'finally when the resource cannot be found' do
            it { subject.must_equal nil }
          end
        end
      end
    end
  end
end
