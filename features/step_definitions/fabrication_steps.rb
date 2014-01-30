require "fabrication"
require_relative "../../test/support/fabrication.rb"

Given(/^a board exists$/) do
  Fabricate(:board)
end

Given(/^a list exists$/) do
  Fabricate(:list)
end

Given(/^a card exists$/) do
  Fabricate(:card)
end

Given(/^a comment exists$/) do
  Fabricate(:comment)
end

Given(/^a member exists$/) do
  Fabricate(:member)
end

Given(/^a default board exists$/) do
  Fabricate(:board, default: true, name: "My Default Board")
end

Given(/^a default list exists$/) do
  Fabricate(:list, default: true, name: "My Default List")
end

Given(/^a default card exists$/) do
  Fabricate(:card, default: true, name: "My Default Card")
end

Given(/^[a|some] boards? exists?\:$/) do |table|
  table.hashes.each do |data|
    Fabricate(:board, data)
  end
end

Given(/^[a|some] lists? exists?\:$/) do |table|
  table.hashes.each do |data|
    Fabricate(:list, data)
  end
end

Given(/^[a|some] cards? exists?\:$/) do |table|
  table.hashes.each do |data|
    Fabricate(:card, data)
  end
end

Given(/^[a|some] comments? exists?\:$/) do |table|
  table.hashes.each do |data|
    Fabricate(:comment, data)
  end
end

Given(/^[a|some] members? exists?\:$/) do |table|
  table.hashes.each do |data|
    Fabricate(:member, data)
  end
end
