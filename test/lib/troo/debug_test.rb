require_relative '../../test_helper'

module Troo
  describe '.debug' do
    let(:filename) { 'profile.html' }
    let(:result)   { mock('result') }
    let(:file)     { mock('file') }
    let(:printer)  { mock('printer') }

    before do
      RubyProf.stubs(:start)
      RubyProf.stubs(:stop).returns(result)
      result.stubs(:eliminate_methods!)
      File.stubs(:open).yields(file)
      RubyProf::CallStackPrinter.stubs(:new).returns(printer)
      printer.stubs(:print)
    end

    subject { Troo.debug(filename) { :some_code } }

    it 'produces a pretty call stack' do
      subject.must_equal nil
    end
  end
end
