Fabricator(:board, from: Troo::Board) do
  external_board_id "526d8e130a14a9d846001d96"
  name              "My Test Board"
  description       "A very brief description..."
  current           false
  closed            false
end

Fabricator(:list, from: Troo::List) do
  external_board_id "526d8e130a14a9d846001d96"
  external_list_id  "526d8e130a14a9d846001d97"
  name              "My Test List"
  position          32768
  current           false
  closed            false
end

Fabricator(:card, from: Troo::Card) do
  external_board_id   "526d8e130a14a9d846001d96"
  external_list_id    "526d8e130a14a9d846001d97"
  external_card_id    "526d8f19ddb279532e005259"
  external_member_ids ["5195fdb5a8c01a2318004f5d"]
  short_id            "67"
  name                "My Test Card"
  desc                "some description"
  url                 "some trello url"
  position            16
  last_activity_date  "2013-12-17 21:48:09 UTC"
  current             false
  closed              false
end

Fabricator(:comment, from: Troo::Comment) do
  external_board_id   "526d8e130a14a9d846001d96"
  external_card_id    "526d8f19ddb279532e005259"
  external_comment_id "51f9277b2822b8654f0023af"
  external_member_id  "5195fdb5a8c01a2318004f5d"
  text                "My Test Comment"
  date                "2013-12-17 22:01:13 UTC"
end

Fabricator(:member, from: Troo::Member) do
  external_member_id "5195fdb5a8c01a2318004f5d"
  username           "gavinlaking1"
  email              "gavinlaking@gmail.com"
  full_name          "Gavin Laking"
  initials           "GL"
  avatar_id          "some_avatar_id"
  bio                "some bio"
  url                "http://www.gavinlaking.name/"
end
