require 'rubygems'
require 'active_support'
require 'action_controller'
require 'init'

RSpec.configure do |config|
  config.mock_with :mocha
end

class TestController < ActionController::Base
end

class DummyFlash 

  DUMMY_DATA = {
    "key1" => "value1",
    "key2" => "value2"
  }

  def [](k)
    DUMMY_DATA[k]
  end

  def []=(k,v)
    DUMMY_DATA[k] = v
  end

  def each(&block)
    DUMMY_DATA.each &block
  end

end
