#!/usr/bin/env ruby

require 'yaml'
require 'git'
require 'fileutils'
require_relative 'workspace'

class Dotfiles
  def initialize
    @global_config = YAML.load_file('config/config.yaml')
    @config = @global_config['dotfiles']
    @workspace = Workspace.new.directory
  end


  def dotfiledir
    File.join(@workspace, 'dotfiles')
  end

  def repo
    dotfile_repo = @config['repo']
    if Git.ls_remote(dotfile_repo)
      unless File.exist?(dotfiledir)
        puts "Cloning #{dotfile_repo}"
        Git.clone(dotfile_repo, 'dotfiles', :path => @workspace)
      else
        g = Git.init(dotfiledir)
        puts "Pulling latest #{dotfile_repo}"
        g.pull
      end
    end
  end


  def link
    if @config['manage']
      dotfiles = @config['files']

      if repo
        dotfiles.each do |file|
          source_file = "#{dotfiledir}/#{file}"

          raise "#{source_file} doesn't exist! Check your config or repo" unless File.exist?(source_file)

          link_file = File.join(Dir.home, file.prepend('.'))

          if File.exist?(link_file)
            FileUtils.remove_file(link_file)
          end

          puts "Linking #{source_file} to #{link_file}"
          FileUtils.ln_sf(source_file, link_file)
        end
      end
    end
  end
end
