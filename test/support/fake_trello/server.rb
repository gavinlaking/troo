require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'

# 1) create own SSL certificate .crt and .key files:
# openssl req -new -x509 -nodes -out my-server.crt -keyout my-server.key
# 2) sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80
# 3) sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
# 4) add 127.0.0.1 api.trello.com to /etc/hosts
# 5) when done:
# remove entry from /etc/hosts
# sudo ipfw del 100
# sudo ipfw del 101

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

class Response
  def self.render!(resource, collection = false)
    path = File.dirname(__FILE__)
    file = "/../remotes/#{resource}.json"
    json = File.read(path + file)
    collection ? '[' + json + ']' : json
  end
end

class MyFakeTrello < Sinatra::Base

  # boards_all
  get '/1/members/me/boards' do
    Response.render!('all_boards', true)
  end

  # board_by_id
  get '/1/boards/:id' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('board')
  end

  # card_by_id
  get '/1/cards/:id' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card')
  end

  # list_by_id
  get '/1/lists/:id' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('list')
  end

  # member_by_id
  get '/1/members/:id' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('member')
  end

  # cards_by_board_id
  get '/1/boards/:id/cards' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card', true)
  end

  # cards_by_list_id
  get '/1/lists/:id/cards' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card', true)
  end

  # comments_by_board_id
  get '/1/boards/:id/actions' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('comment')
  end

  # comments_by_card_id
  get '/1/cards/:id/actions' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('comment')
  end

  # comments_by_list_id
  get '/1/lists/:id/actions' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('comment')
  end

  # lists_by_board_id
  get '/1/boards/:id/lists' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('list', true)
  end

  # members_by_board_id
  get '/1/boards/:id/members' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('member', true)
  end

  # create_board
  post '/1/boards' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('board')
  end

  # create_card
  post '/1/cards' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card')
  end

  # create_comment
  post '/1/cards/:id/actions/comments' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('comment')
  end

  # create_list
  post '/1/lists' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('list')
  end

  # move_card_list
  put '/1/cards/:id/idList' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card')
  end

  # move_card_board
  put '/1/cards/:id/idBoard' do
    halt(400, 'Bad Request')  if params['id'] == '400'
    halt(401, 'Unauthorized') if params['id'] == '401'
    Response.render!('card')
  end
end

Rack::Handler::WEBrick.run MyFakeTrello, webrick_options
