$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'simplecov'
SimpleCov.start

require "myosx"

Dir[File.dirname(__FILE__) + '/lib/myosx/*.rb'].each {|file| require file }

ENV.delete('MYOSX_WORKSPACE')
ENV.delete('MYOSX_CONFIG')
