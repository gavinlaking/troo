require_relative '../../../test_helper'

module Troo
  module API
    describe Response do
      let(:described_class) { Response }
      let(:api_response)    { OpenStruct.new(code: code, body: body) }
      let(:code)            { "200" }
      let(:body)            { '{"key":"some_value"}' }

      describe "#initialize" do
        subject { described_class.new(api_response) }

        it 'assigns the api_response to an instance variable' do
          subject.instance_variable_get('@api_response')
            .must_equal(api_response)
        end
      end

      describe "#status_code" do
        subject { described_class.new(api_response).status_code }

        it "returns the status code of the HTTP request" do
          subject.must_equal(200)
        end
      end

      describe "#body" do
        subject { described_class.new(api_response).body }

        context "when the request was successful" do
          let(:code) { "200" }

          it "returns the parsed JSON response" do
            subject.must_equal({"key" => "some_value"})
          end
        end

        context "when the request was unauthorized" do
          let(:code) { "401" }

          it "raises an exception" do
            proc { subject }.must_raise(InvalidAccessToken)
          end
        end

        context "when the request was something else" do
          let(:code) { "" }

          it "raises an exception" do
            proc { subject }.must_raise(GenericAPIError)
          end
        end
      end
    end
  end
end
