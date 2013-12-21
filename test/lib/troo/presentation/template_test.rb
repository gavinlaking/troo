require_relative "../../../test_helper"

module Troo
  describe Template do
    let(:described_class) { Template }
    let(:object) { }
    let(:template_file) { }

    describe "#initialize" do
      subject { described_class.new(object, template_file) }

      it "assigns the object to an instance variable" do
        subject.instance_variable_get("@object").must_equal(object)
      end

      it "assigns the template_file to an instance variable" do
        subject.instance_variable_get("@template_file").must_equal(template_file)
      end
    end

    describe ".parse" do
      subject { described_class.parse(object, template_file) }

      it "" do
      end
    end
  end
end
