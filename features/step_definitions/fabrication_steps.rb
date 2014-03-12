require 'fabrication'
require_relative '../../test/support/fabrication.rb'

Given(/^a board exists$/) do
  Fabricate(:board, external_id: 20010)
end

Given(/^a list exists$/) do
  Fabricate(:board)
  Fabricate(:list, external_id: 20040)
end

Given(/^a card exists$/) do
  Fabricate(:board)
  Fabricate(:list)
  Fabricate(:member)
  Fabricate(:card, external_id: 20020)
end

Given(/^a comment exists$/) do
  Fabricate(:card, external_id: 20020)
  Fabricate(:member)
  Fabricate(:comment, external_card_id: 20020)
end

Given(/^(\d+) comments exist$/) do |count|
  Fabricate(:card, external_id: 20020)
  Fabricate(:member)
  count.to_i.times do
    Fabricate(:comment, external_card_id: 20020)
  end
end

Given(/^a default board exists$/) do
  Fabricate(:board, default: true,
                    name: 'My Default Board',
                    external_id: 20010)
end

Given(/^a default list exists$/) do
  Fabricate(:board)
  Fabricate(:list, default: true,
                   name: 'My Default List',
                   external_id: 20040)
end

Given(/^a default card exists$/) do
  Fabricate(:board)
  Fabricate(:list)
  Fabricate(:member)
  Fabricate(:card, default: true,
                   name:    'My Default Card',
                   external_id: 20020)
end

Given(/^local data exists, all defaults set$/) do
  Fabricate(:board, default: true, name: 'My Default Board')
  Fabricate(:list,  default: true, name: 'My Default List')
  Fabricate(:card,  default: true, name: 'My Default Card')
  Troo::Refresh.completed!
end

Given(/^local data exists$/) do
  Fabricate(:board, default: true, name: 'My Default Board')
  Fabricate(:board)
  Fabricate(:list, default: true, name: 'My Default List')
  Fabricate(:card, external_id: 20020)
  Troo::Refresh.completed!
end
