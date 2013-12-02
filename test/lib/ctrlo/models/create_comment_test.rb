require_relative "../../../test_helper"

module Ctrlo
  describe CreateComment do
    describe "#create" do
      subject { CreateComment.for("526d8f19ddb279532e005259", comment) }

      before do
        VCR.insert_cassette(:create_comment)
      end

      after do
        VCR.eject_cassette
      end

      describe "when a comment is supplied" do
        let(:comment) { "This is a test comment." }

        it "creates a comment on the specified card" do
          parsed_subject = JSON.parse(subject).fetch("memberCreator").fetch("fullName")
          parsed_subject.must_equal "Gavin Laking"
        end
      end

      describe "when a comment is not supplied" do
        let(:comment) { }

        before do
          Input.stubs(:get).returns("This is a test comment.")
        end

        it "creates a comment on the specified card" do
          parsed_subject = JSON.parse(subject).fetch("memberCreator").fetch("fullName")
          parsed_subject.must_equal "Gavin Laking"
        end
      end
    end
  end
end
