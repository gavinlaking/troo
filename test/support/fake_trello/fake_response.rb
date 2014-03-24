require 'json'
require 'yajl'

class FakeResponse
  def self.render(resource, id = nil, collection = false)
    new(resource, id, collection).render
  end

  def initialize(resource, id = nil, collection = false)
    @resource, @id, @collection = resource, id, collection
  end

  def render
    collection ? '[' + output + ']' : output
  end

  private

  attr_reader :resource, :id, :collection

  def output
    return converted if id
    raw
  end

  def converted
    JSON(parsed)
  end

  def parsed
    @parsed ||= Yajl::Parser.parse(raw).merge!('id' => id)
  end

  def raw
    @raw ||= File
      .read(File.dirname(__FILE__) + '/../remotes/' + filename)
  end

  def filename
    testing || reality
  end

  def testing
    resource + '_200.json' if testing?
  end

  def testing?
    id =~ /^200/
  end

  def reality
    return [resource, '_', id, '.json'].join if id
    [resource, '.json'].join
  end
end
