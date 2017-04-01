#!/usr/bin/env ruby
# Config class
#
require 'yaml'
require 'git'

class Config
  def config_file
    ENV["MYOSX_CONFIG"] || File.expand_path('~/.myosx.cnf')
  end

  def global
    YAML.load_file(config_file)
  end

  def workspace_directory
    ENV['MYOSX_WORKSPACE'] || File.expand_path('~/.myosx/')
  end

  def create_workspace(directory)
    unless Dir.exists?(directory)
      puts "Creating workspace: #{directory}"
      Dir.mkdir("#{directory}", 0750)
    end
  end
end
