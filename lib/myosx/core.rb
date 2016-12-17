#!/usr/bin/env ruby
# Core class
#
require 'yaml'
require 'git'
require 'fileutils'
require_relative 'workspace'

class Core
  def initialize
    $global_config = YAML.load_file('config/config.yaml')
    $workspace = Workspace.new.directory
  end
end
