require_relative '../../../test_helper'

module Troo
  module API
    describe Request do
      let(:described_class) { Request }
      let(:verb)  { :get }
      let(:uri)   { 'http://www.example.com/' }
      let(:query) { {} }

      before do
        RestClient::Request.stubs(:execute)
      end

      describe '#initialize' do
        subject { described_class.new(verb, uri, query) }

        it 'assigns the verb to an instance variable' do
          subject.instance_variable_get('@verb').must_equal(verb)
        end

        it 'assigns the uri to an instance variable' do
          subject.instance_variable_get('@uri').must_equal(uri)
        end

        it 'assigns the query to an instance variable' do
          subject.instance_variable_get('@query').must_equal(query)
        end
      end

      describe '.make' do
        let(:request) { Response.new }

        before do
          RestClient::Request.stubs(:execute).returns(request)
        end

        subject { described_class.make(verb, uri, query) }

        context 'when Trello can be reached' do
          it 'returns a Response we can process further' do
            subject.must_be_instance_of(Response)
          end
        end

        context 'when Trello cannot be reached' do
          before do
            RestClient::Request.stubs(:execute)
              .raises(Errno::ECONNREFUSED)
          end

          it 'returns an ErrorResponse we can process further' do
            subject.must_be_instance_of(ErrorResponse)
          end
        end

        context 'when there is no network connection' do
          before do
            RestClient::Request.stubs(:execute).raises(SocketError)
          end

          it 'returns an ErrorResponse we can process further' do
            subject.must_be_instance_of(ErrorResponse)
          end
        end

        context 'when the request raises an exception' do
          before do
            RestClient::Request.stubs(:execute).raises(RestClient::Exception)
          end

          it 'returns an ErrorResponse we can process further' do
            subject.must_be_instance_of(ErrorResponse)
          end
        end
      end
    end
  end
end
