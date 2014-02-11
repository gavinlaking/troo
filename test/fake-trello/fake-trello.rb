require 'rubygems'
require 'sinatra'

get '/hello' do
  "Hello!"
end

# board_by_id
# boards/526d8e130a14a9d846001d96
get '/boards/:id' do
 "{\"id\":\"526d8e130a14a9d846001d96\",\"name\":\"Troo App\",\"desc\":\"\",\"descData\":null,\"closed\":false,\"idOrganization\":null,\"pinned\":true,\"url\":\"<Trello URL>\",\"shortUrl\":\"<Trello URL>\",\"prefs\":{\"permissionLevel\":\"private\",\"voting\":\"disabled\",\"comments\":\"members\",\"invitations\":\"members\",\"selfJoin\":false,\"cardCovers\":true,\"cardAging\":\"regular\",\"background\":\"blue\",\"backgroundColor\":\"#205C7E\",\"backgroundImage\":null,\"backgroundImageScaled\":null,\"backgroundTile\":false,\"backgroundBrightness\":\"unknown\",\"canBePublic\":true,\"canBeOrg\":true,\"canBePrivate\":true,\"canInvite\":true},\"labelNames\":{\"yellow\":\"Analysis Complete\",\"red\":\"\",\"purple\":\"\",\"orange\":\"\",\"green\":\"Ready to Pull\",\"blue\":\"\"}}"
end

# boards_all
# members/gavinlaking1/boards
get '/members/:user_id/boards' do
end

# card_by_card_id
# cards/526d8f19ddb279532e005259
get '/cards/:id' do
end

# cards_by_board_id
# boards/526d8e130a14a9d846001d96/cards?filter=open
get '/boards/:id/cards?filter=open' do
end

# cards_by_list_id
# lists/526d8e130a14a9d846001d97/cards?filter=open
get '/lists/:id/cards?filter=open' do
end

# comments_by_board_id
# boards/526d8e130a14a9d846001d96/actions?filter=commentCard
get '/boards/:id/actions?filter=commentCard' do
end

# comments_by_card_id
# cards/526d8f19ddb279532e005259/actions?filter=commentCard
get '/cards/:id/actions?filter=commentCard' do
end

# comments_by_list_id
# lists/526d8e130a14a9d846001d97/actions?filter=commentCard
get '/lists/:id/actions?filter=commentCard' do
end

# create_board
# boards
# name=My%20New%20Board&desc=A%20very%20brief%20description...
# post '/' do
# end

# create_card
# cards
# name=My%20New%20Card&desc=A%20description%20to%20get%20us%20started.&idList=526d8e130a14a9d846001d97
# post '/' do
# end

# create_comment
# cards/526d8f19ddb279532e005259/actions/comments
# text=Some%20much%20needed%20feedback...
# post '/' do
# end

# create_list
# lists
# name=My%20New%20List&closed=false&idBoard=526d8e130a14a9d846001d96
# post '/' do
# end

# list_by_list_id
# lists/526d8e130a14a9d846001d97
get '/lists/:id' do
end

# lists_by_board_id
# boards/526d8e130a14a9d846001d96/lists?filter=open
get '/boards/:id/lists?filter=open' do
end

# member_by_member_id
# members/5195fdb5a8c01a2318004f5d
get '/members/:id' do
end

# members_by_board_id
# boards/526d8e130a14a9d846001d96/members?filter=all
get '/boards/:id/members?filter=all' do
end

# move_card
# cards/526d8f19ddb279532e005259/idList
# get '/cards/:id/idList' do
# end
