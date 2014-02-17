require 'addressable/uri'
require 'date'
require 'erb'
require 'fileutils'
require 'logger'
require 'json'
require 'net/http'
require 'oauth'
require 'ohm'
require 'ohm/contrib'
require 'pry'
require 'pry-nav'
require 'rest_client'
require 'securerandom'
require 'singleton'
require 'term/ansicolor'
require 'thor'
require 'virtus'
require 'yajl'
require 'yaml'

require_relative 'configuration'

require_relative 'api/endpoints'
require_relative 'api/oauth_settings'
require_relative 'api/headers'
require_relative 'api/request'
require_relative 'api/response'
require_relative 'api/client'

require_relative 'helpers/command_helpers'
require_relative 'helpers/decorator_helpers'
require_relative 'helpers/model_helpers'

require_relative 'actions/create_board'
require_relative 'actions/create_card'
require_relative 'actions/create_comment'
require_relative 'actions/create_list'
require_relative 'actions/move_card'

require_relative 'adaptors/resource'
require_relative 'adaptors/board'
require_relative 'adaptors/card'
require_relative 'adaptors/comment'
require_relative 'adaptors/list'
require_relative 'adaptors/member'

require_relative 'external/resource'
require_relative 'external/board'
require_relative 'external/card'
require_relative 'external/comment'
require_relative 'external/list'
require_relative 'external/member'

require_relative 'decorators/board'
require_relative 'decorators/card'
require_relative 'decorators/comment'
require_relative 'decorators/list'
require_relative 'decorators/member'

require_relative 'presentation/sentence'
require_relative 'presentation/template'

require_relative 'presenters/board'
require_relative 'presenters/card'
require_relative 'presenters/comment'
require_relative 'presenters/list'
require_relative 'presenters/member'

require_relative 'models/behaviours/set_default'

require_relative 'models/persistence/resource'
require_relative 'models/persistence/board'
require_relative 'models/persistence/card'
require_relative 'models/persistence/comment'
require_relative 'models/persistence/list'
require_relative 'models/persistence/member'

require_relative 'models/remote/board'
require_relative 'models/remote/card'
require_relative 'models/remote/comment_data_card'
require_relative 'models/remote/comment_data_board'
require_relative 'models/remote/comment_data'
require_relative 'models/remote/comment'
require_relative 'models/remote/list'
require_relative 'models/remote/member'

require_relative 'models/retrieval/resource'
require_relative 'models/retrieval/board'
require_relative 'models/retrieval/card'
require_relative 'models/retrieval/comment'
require_relative 'models/retrieval/list'
require_relative 'models/retrieval/member'

require_relative 'models/board'
require_relative 'models/card'
require_relative 'models/comment'
require_relative 'models/list'
require_relative 'models/member'
require_relative 'models/refresh'

require_relative 'commands/commands'
require_relative 'commands/default'

require_relative 'cli/thor_fixes'
require_relative 'cli/add'
require_relative 'cli/default'
require_relative 'cli/refresh'
require_relative 'cli/show'
require_relative 'cli/main'
