require 'fabrication'
require_relative '../../test/support/fabrication.rb'

Given(/^a board exists$/) do
  Fabricate(:board, external_board_id: 200)
end

Given(/^a list exists$/) do
  Fabricate(:board)
  Fabricate(:list, external_list_id: 200)
end

Given(/^a card exists$/) do
  Fabricate(:board)
  Fabricate(:list)
  Fabricate(:member)
  Fabricate(:card, external_card_id: 200)
end

Given(/^a comment exists$/) do
  Fabricate(:card, external_card_id: 200)
  Fabricate(:member)
  Fabricate(:comment, external_card_id: 200)
end

Given(/^a default board exists$/) do
  Fabricate(:board, default: true, name: 'My Default Board')
end

Given(/^a default list exists$/) do
  Fabricate(:board)
  Fabricate(:list, default: true, name: 'My Default List')
end

Given(/^a default card exists$/) do
  Fabricate(:board)
  Fabricate(:list)
  Fabricate(:member)
  Fabricate(:card, default: true,
                   name:    'My Default Card',
                   external_card_id: 200)
end

Given(/^local data exists, all defaults set$/) do
  Fabricate(:board, default: true, name: 'My Default Board')
  Fabricate(:list,  default: true, name: 'My Default List')
  Fabricate(:card,  default: true, name: 'My Default Card')
end

Given(/^local data exists$/) do
  Fabricate(:board, default: true, name: 'My Default Board')
  Fabricate(:board)
  Fabricate(:list, default: true, name: 'My Default List')
  Fabricate(:card, external_card_id: 200)
end
