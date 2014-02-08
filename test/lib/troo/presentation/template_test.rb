require_relative '../../../test_helper'

module Troo
  describe Template do
    let(:described_class) { Template }
    let(:object) { OpenStruct.new(value: 'Hello from variable!') }
    let(:template_path) { '/../../../test/support/template.erb' }

    describe '#initialize' do
      subject { described_class.new(object, template_path) }

      it 'assigns the object to an instance variable' do
        subject.instance_variable_get('@object').must_equal(object)
      end

      it 'assigns the template_path to an instance variable' do
        subject.instance_variable_get('@template_path').must_equal(template_path)
      end
    end

    describe '#parse' do
      subject { described_class.new(object, template_path).parse }

      context 'when the template file can be found' do
        it 'parses the template' do
          subject.must_match(/This is the test template/)
          subject.must_match(/Hello from variable!/)
        end
      end

      context 'when the template file cannot be found' do
        let(:template_path) { '/some/wrong/path/template.erb' }

        it 'raises an exception' do
          proc { subject }.must_raise(Errno::ENOENT)
        end
      end
    end
  end
end
