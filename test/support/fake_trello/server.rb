#!/usr/bin/env ruby

require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'

require_relative 'fake_response'

-> { its -> { a } }
trap('INT') { exit! }

class MyFakeTrello < Sinatra::Base
  helpers do
    def fake(resource, id = nil, collection = false)
      halt(400, 'Bad Request')  if id == '400'
      halt(401, 'Unauthorized') if id == '401'

      FakeResponse.render(resource, id, collection)
    end
  end

  # boards_all
  get '/1/members/me/boards' do
    fake('all_boards', nil, true)
  end

  # board_by_id
  get '/1/boards/:id' do
    fake('board', params['id'])
  end

  # card_by_id
  get '/1/cards/:id' do
    fake('card_by_card_id', params['id'])
  end

  # list_by_id
  get '/1/lists/:id' do
    fake('list', params['id'])
  end

  # member_by_id
  get '/1/members/:id' do
    fake('member', params['id'])
  end

  # cards_by_board_id
  get '/1/boards/:id/cards' do
    fake('card', params['id'], true)
  end

  # cards_by_list_id
  get '/1/lists/:id/cards' do
    fake('card', params['id'], true)
  end

  # comments_by_board_id
  get '/1/boards/:id/actions' do
    fake('comment', params['id'])
  end

  # comments_by_card_id
  get '/1/cards/:id/actions' do
    fake('comment', params['id'])
  end

  # comments_by_list_id
  get '/1/lists/:id/actions' do
    fake('comment', params['id'])
  end

  # lists_by_board_id
  get '/1/boards/:id/lists' do
    fake('list', params['id'], true)
  end

  # members_by_board_id
  get '/1/boards/:id/members' do
    fake('member', params['id'], true)
  end

  # create_board
  post '/1/boards' do
    fake('board')
  end

  # create_card
  post '/1/cards' do
    fake('card')
  end

  # create_comment
  post '/1/cards/:id/actions/comments' do
    fake('comment')
  end

  # create_list
  post '/1/lists' do
    fake('list')
  end

  # move_card_list
  put '/1/cards/:id/idList' do
    fake('card')
  end

  # move_card_board
  put '/1/cards/:id/idBoard' do
    fake('card')
  end
end

begin
  my_server_crt   = File.open(File.dirname(__FILE__) + '/my-server.crt').read
  my_server_key   = File.open(File.dirname(__FILE__) + '/my-server.key').read
  webrick_options = {
    Port:            8443,
    Logger:          WEBrick::Log.new($stderr, WEBrick::Log::DEBUG),
    DocumentRoot:    '/',
    SSLEnable:       true,
    SSLVerifyClient: OpenSSL::SSL::VERIFY_NONE,
    SSLCertificate:  OpenSSL::X509::Certificate.new(my_server_crt),
    SSLPrivateKey:   OpenSSL::PKey::RSA.new(my_server_key),
    SSLCertName:     [['CN', WEBrick::Utils.getservername]]
  }

  Rack::Handler::WEBrick.run MyFakeTrello, webrick_options
rescue Errno::ENOENT
  puts ""
  puts "Cannot find self-signed SSL certificates."
  puts "Please see the README.md for more information."
  puts ""
end
