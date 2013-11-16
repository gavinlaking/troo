require_relative "../../../test_helper"

module Trlo
  describe ShowCard do
    describe "#show" do
      let(:card_id)  { "some_24bit_card_id" }
      let(:card)     { OpenStruct.new({
                         id:       "some_24bit_card_id",
                         short_id: "1",
                         name:     "Implement 'ShowCard'",
                         comments: comments }) }
      let(:comment)  { Comment.decorate(OpenStruct.new({
                         member_creator_id: "some_24bit_member_id",
                         data:              { "text" => "Writing some tests." },
                         date:              Time.parse("2013-11-12 20:26:58 UTC") })) }
      let(:comments) { [comment] }

      subject { ShowCard.with(card_id) }

      before do
        FindCard.stubs(:with).returns(card)
        FindComments.stubs(:for).returns(comments)
        # card.stubs(:actions).returns(comments)
      end

      it "presents the card by card_id" do
        subject.must_equal({ :id       => "some_24bit_card_id",
                             :short_id => "1",
                             :name     => "Implement 'ShowCard'",
                             :comments => [{ :member   => "some_24bit_member_id",
                                             :text     => "Writing some tests.",
                                             :date     => "2013-11-12 20:26:58 UTC" }],
                             :header   => { :short_id => "ID",
                                            :name     => "Name" } })
      end
    end
  end
end
