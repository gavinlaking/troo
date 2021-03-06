require 'addressable/uri'
require 'date'
require 'dispel'
require 'erb'
require 'fileutils'
require 'json'
require 'launchy'
require 'logger'
require 'net/http'
require 'oauth'
require 'ohm'
require 'ohm/contrib'
require 'rest_client'
require 'securerandom'
require 'singleton'
require 'term/ansicolor'
require 'thor'
require 'virtus'
require 'yajl'
require 'yaml'

require_relative 'preference'
require_relative 'configuration'
require_relative 'database'
require_relative 'debug'
require_relative 'options'

require_relative 'api/endpoints'
require_relative 'api/oauth_settings'
require_relative 'api/headers'
require_relative 'api/request'
require_relative 'api/response'
require_relative 'api/client'

require_relative 'helpers/decorator_helpers'
require_relative 'helpers/model_helpers'
require_relative 'helpers/remote_model_helpers'

require_relative 'remote/persistence/board'
require_relative 'remote/persistence/card'
require_relative 'remote/persistence/comment'
require_relative 'remote/persistence/list'
require_relative 'remote/persistence/move_card'

require_relative 'decorators/resource'

require_relative 'presentation/align'
require_relative 'presentation/compositor'
require_relative 'presentation/esc'
require_relative 'presentation/format'
require_relative 'presentation/formatter'
require_relative 'presentation/output'
require_relative 'presentation/sentence'
require_relative 'presentation/template'
require_relative 'presentation/wordwrap'

require_relative 'presenters/board'
require_relative 'presenters/card'
require_relative 'presenters/comment'
require_relative 'presenters/list'
require_relative 'presenters/member'
require_relative 'presenters/resource'

require_relative 'persistence/local'

require_relative 'remote/all'

require_relative 'retrieval/remote'
require_relative 'retrieval/local'

require_relative 'models/behaviours/set_default'
require_relative 'models/board'
require_relative 'models/card'
require_relative 'models/comment'
require_relative 'models/list'
require_relative 'models/member'
require_relative 'models/refresh'

require_relative 'cli/commands/show/show_boards'
require_relative 'cli/commands/show/show_comments'
require_relative 'cli/commands/show'
require_relative 'cli/commands/add'
require_relative 'cli/commands/move/card'
require_relative 'cli/commands/refresh/all'
require_relative 'cli/commands/default'
require_relative 'cli/commands/refresh'
require_relative 'cli/commands/status'

require_relative 'cli/thor_fixes'
require_relative 'cli/add'
require_relative 'cli/default'
require_relative 'cli/refresh'
require_relative 'cli/show'
require_relative 'cli/wizard'
require_relative 'cli/main'

require_relative 'launcher'
