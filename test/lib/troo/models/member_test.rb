require_relative "../../../test_helper"

module Troo
  describe Member do
    let(:described_class) { Member }

    before do
      @member = Fabricate(:member)
    end

    after do
      database_cleanup
    end

    it "should have a username attribute" do
      @member.username.must_equal "gavinlaking1"
    end

    it "should have an email attribute" do
      @member.email.must_equal "gavinlaking@gmail.com"
    end

    it "should have a full_name attribute" do
      @member.full_name.must_equal "Gavin Laking"
    end

    it "should have an initials attribute" do
      @member.initials.must_equal "GL"
    end

    it "should have an avatar_id attribute" do
      @member.avatar_id.must_equal "some_avatar_id"
    end

    it "should have a bio attribute" do
      @member.bio.must_equal "some bio"
    end

    it "should have a url attribute" do
      @member.url.must_equal "http://www.gavinlaking.name/"
    end

    it "should have an external_member_id attribute" do
      @member.external_member_id.must_equal "5195fdb5a8c01a2318004f5d"
    end

  end
end
