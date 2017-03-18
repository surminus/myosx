#!/usr/bin/env ruby
# Core class
#
require 'yaml'
require 'git'
require_relative 'workspace'

class Core
  def initialize
    config_file = File.expand_path('~/.myosx.cnf')
    raise "Cannot find config file: #{config_file}" unless File.exist?(config_file)
    $global_config = YAML.load_file(config_file)
    $workspace = Workspace.new.directory
  end
end
