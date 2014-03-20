require_relative '../../../test_helper'

class ModelHelpersDummy < Ohm::Model
  include Troo::ModelHelpers

  attribute :name
  attribute :default

  index     :name
  index     :default
end

module Troo
  describe ModelHelpersDummy do
    let(:described_class) { ModelHelpersDummy }

    before do
      @dumb   = ModelHelpersDummy.create(
                 name: 'My Dumb Model',
                 default: false)
      @dumber = ModelHelpersDummy.create(
                 name: 'My Dumber Model',
                 default: true)
    end

    after { database_cleanup }

    describe '.first' do
      subject { described_class.first(criteria) }

      context 'when no criteria are provided' do
        let(:criteria) {}

        it 'returns the first model stored of that type' do
          subject.name.must_equal('My Dumb Model')
        end
      end

      context 'when criteria are provided' do
        let(:criteria) { { name: 'My Dumber Model' } }

        it 'returns the first model matching the criteria' do
          subject.name.must_equal('My Dumber Model')
        end
      end
    end

    describe '.update' do
      subject { described_class.update(criteria) }

      context 'when no criteria are provided' do
        let(:criteria) {}

        it 'returns false; no update was performed' do
          subject.must_equal(false)
        end
      end

      context 'when criteria are provided' do
        let(:criteria) { { name: 'My Updated Model' } }

        it 'updates all records with the criteria' do
          subject.must_equal(true)
          ModelHelpersDummy.all.each do |dummy|
            dummy.name.must_equal('My Updated Model')
          end
        end
      end
    end

    describe '.default' do
      subject { described_class.default }

      context 'when there is a default model' do
        it 'returns the model' do
          subject.must_equal(@dumber)
        end
      end

      context 'when there is no default model' do
        before { @dumber.delete }

        it { subject.must_equal(nil) }
      end
    end

    describe '.default?' do
      subject { described_class.default? }

      context 'when there is a default model' do
        it { subject.must_equal true }
      end

      context 'when there is no default model' do
        before { @dumber.delete }

        it { subject.must_equal false }
      end
    end

    describe '.count' do
      let(:criteria) { {} }

      subject { described_class.count(criteria) }

      context 'when no criteria is specified' do
        it 'returns the number of this model persisted' do
          subject.must_equal(2)
        end
      end

      context 'when criteria is specified' do
        let(:criteria) { { name: 'My Dumber Model' } }

        it 'returns the number of this model persisted' do
          subject.must_equal(1)
        end
      end
    end

    describe '.retrieve' do
      subject { described_class.retrieve(id, options) }
    end
  end
end
