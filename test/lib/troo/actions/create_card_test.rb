require_relative "../../../test_helper"

module Troo
  describe CreateCard do
    let(:described_class) { CreateCard }
    let(:list_id)  { "526d8e130a14a9d846001d97" }
    let(:card_name) { "My New Card" }
    let(:description) { "A description to get us started." }

    before do
      @list = Fabricate(:list)

      Trello::Card.stubs(:create).returns()
      Troo::ListRetrieval.stubs(:retrieve).returns(@list)
      Input.stubs(:get).returns("input stub")
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(list_id, card_name, description) }

      it "assigns the list_id to an instance variable" do
        subject.instance_variable_get("@list_id").must_equal(list_id)
      end

      it "assigns the name to an instance variable" do
        subject.instance_variable_get("@name").must_equal(card_name)
      end

      it "assigns the description to an instance variable" do
        subject.instance_variable_get("@description").must_equal(description)
      end
    end

    describe "#create" do
      before { VCR.insert_cassette(:create_card, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(list_id, card_name) }

      context "when a new card name is provided" do
        it "creates the card and returns an instance of this class" do
          subject.must_be_instance_of(described_class)
        end
      end

      context "when a new card name is not provided" do
        let(:card_name) { nil }
        let(:user_input_card_name) { "My New Card" }

        before do
          Input.stubs(:get).returns(user_input_card_name)
        end

        it "asks the user to enter a name and creates the card" do
          subject.must_be_instance_of(described_class)

          subject.name.must_equal(user_input_card_name)
        end
      end

      context "when a new card description is provided" do
        it "creates the card and returns an instance of this class" do
          subject.must_be_instance_of(described_class)
        end
      end

      context "when a new card description is not provided" do
        let(:description) { nil }
        let(:user_input_description) { "A very brief description..." }

        before do
          Input.stubs(:get).returns(user_input_description)
        end

        it "asks the user to enter a description and creates the card" do
          subject.must_be_instance_of(described_class)

          subject.description.must_equal(user_input_description)
        end
      end
    end

    context "it exposes various attributes we will use later" do
      subject { described_class.new(list_id, card_name, description) }

      describe "#list_name" do
        it "returns the list name" do
          subject.list_name.must_equal(@list.name)
        end
      end

      describe "#external_list_id" do
        it "returns the external_list_id" do
          subject.external_list_id.must_equal(list_id)
        end
      end

      describe "#name" do
        it "returns the name" do
          subject.name.must_equal(card_name)
        end
      end

      describe "#description" do
        it "returns the description" do
          subject.description.must_equal(description)
        end
      end
    end
  end
end
