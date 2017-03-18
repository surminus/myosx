#!/usr/bin/env ruby
# Config class
#
require 'yaml'
require 'git'

class Config
  def initialize
    config_location = ENV['MYOSX_CONFIG'] || '~/.myosx.cnf'
    config_file = File.expand_path(config_location)
    raise "Cannot find config file: #{config_file}" unless File.exist?(config_file)
    $global_config = YAML.load_file(config_file)
    $workspace = workspace_directory
  end

  def workspace_directory
    workspace_dir_name = ENV['MYOSX_WORKSPACE'] || '~/.myosx/'
    return File.expand_path(workspace_dir_name)
  end

  def create_workspace
    unless Dir.exists?($workspace)
      puts "Creating workspace: #{workspace_directory}"
      Dir.mkdir("#{workspace_directory}", 0750)
    end
  end
end
