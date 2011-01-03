require 'rubygems'
require 'active_support'
require 'action_controller'
require 'init'

RSpec.configure do |config|
  config.mock_with :mocha
end

class TestController < ActionController::Base

  def results
    @results ||= []
  end

  def callback1(message)
    results << "callback1 called with #{message}"
  end

  def callback2(message)
    results << "callback2 called with #{message}"
  end
               
end

class DummyFlash 
  
  attr_accessor :results

  DUMMY_DATA = {
    "key1" => "value1",
    "key2" => "value2"
  }

  def intialize
    results = []  
  end

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
