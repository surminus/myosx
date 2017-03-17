#!/usr/bin/env ruby

require 'yaml'

class Workspace
  def initialize
    @config = YAML.load_file(File.expand_path('~/.myosx.cnf'))
  end

  def directory
    workspace_dir_name = @config['workspace']
    return File.join(Dir.home, workspace_dir_name)
  end


  def create
    unless Dir.exists?(directory)
      puts "Creating workspace: #{directory}"
      Dir.mkdir("#{directory}", 0750)
    end
  end

end

