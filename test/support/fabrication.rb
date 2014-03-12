Fabricator(:board, from: Troo::Board) do
  external_id '20010'
  name              'My Test Board'
  description       'A very brief description...'
  default           false
  closed            false
end

Fabricator(:list, from: Troo::List) do
  external_board_id '20010'
  external_id       '20040'
  name              'My Test List'
  position          32_768
  default           false
  closed            false
end

Fabricator(:card, from: Troo::Card) do
  external_board_id   '20010'
  external_list_id    '20040'
  external_id         '20020'
  external_member_ids ['20050']
  short_id            '67'
  name                'My Test Card'
  desc                'some description'
  url                 'some trello url'
  position            16
  last_activity_date  '2013-12-17 21:48:09 UTC'
  default             false
  closed              false
end

Fabricator(:comment, from: Troo::Comment) do
  external_board_id  '20010'
  external_card_id   '20020'
  external_id        '20030'
  external_member_id '20050'
  text               'My Test Comment'
  date               '2013-12-17 22:01:13 UTC'
end

Fabricator(:member, from: Troo::Member) do
  external_id '20050'
  username    'gavinlaking1'
  email       'gavinlaking@gmail.com'
  full_name   'Gavin Laking'
  initials    'GL'
  avatar_id   'some_avatar_id'
  bio         'some bio'
  url         'http://www.gavinlaking.name/'
end

Fabricator(:refresh, from: Troo::Refresh) do
  last_performed_at '2014-01-16 21:00:00 UTC'
end
