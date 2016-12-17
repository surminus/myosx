#!/usr/bin/env ruby

require 'yaml'

class Workspace
  def initialize
    @config = YAML.load_file('config/config.yaml')
  end

  def create
    workspace_dir_name = @config['workspace']
    workspace_dir = File.join(Dir.home, workspace_dir_name)

    unless Dir.exists?("#{workspace_dir}")
      puts "Creating workspace: #{workspace_dir}"
      Dir.mkdir("#{workspace_dir}", 0750)
    end
  end
end

