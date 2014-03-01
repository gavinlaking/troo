require_relative '../../../test_helper'

module Troo
  module Retrieval
    describe Local do
      let(:described_class)  { Local }
      let(:klass)            { stub }
      let(:id)               {}
      let(:options)          {}
      let(:local_resource)   {}
      let(:remote_resource)  { [] }
      let(:default_resource) {}

      before do
        klass.stubs(:default).returns(default_resource)
        klass.stubs(:first).returns(local_resource)
        klass.stubs(:[]).returns(local_resource)
        klass.stubs(:by_external_id).returns(local_resource)
        klass.stubs(:fetch).returns(remote_resource)
      end

      describe '#initialize' do
        subject { described_class.new(klass, id, options) }

        it 'assigns the klass to an instance variable' do
          subject.instance_variable_get('@klass').must_equal(klass)
        end

        it 'assigns the id to an instance variable' do
          subject.instance_variable_get('@id').must_equal(id)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options')
            .must_equal(options)
        end
      end

      describe '.all' do
        before { klass.stubs(:all).returns(collection) }

        subject { described_class.all(klass) }

        context 'when local resources exist' do
          let(:collection) { [:resource, :resource] }

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
