require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'

require_relative 'fake_response'

# 1) create own SSL certificate .crt and .key files:
# openssl req -new -x509 -nodes -out my-server.crt -keyout my-server.key
# 2) sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80
# 3) sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
# 4) add 127.0.0.1 api.trello.com to /etc/hosts
# 5) when done:
# remove entry from /etc/hosts
# sudo ipfw del 100
# sudo ipfw del 101

trap('INT') { exit! }

my_server_crt   = File.open(File.join('./', 'my-server.crt')).read
my_server_key   = File.open(File.join('./', 'my-server.key')).read
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

Rack::Handler::WEBrick.run MyFakeTrello, webrick_options
