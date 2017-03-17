#!/usr/bin/env ruby

require 'yaml'
require 'git'
require 'fileutils'
require_relative 'core'

class Dotfiles
  def initialize
    Core.new
    @config = $global_config['dotfiles']
  end

  def dotfiledir
    File.join($workspace, 'dotfiles')
  end

  def repo(repo)
    if Git.ls_remote(repo)
      unless File.exist?(dotfiledir)
        puts "Cloning #{dotfile_repo}"
        Git.clone(repo, 'dotfiles', :path => $workspace)
      else
        g = Git.init(dotfiledir)
        puts "Pulling latest #{repo}"
        g.pull
      end
    end
  end

  def link(file, dest)
    source_file = "#{dotfiledir}/#{file}"

    dest = File.expand_path(dest)
    raise "#{source_file} doesn't exist! Check your config or repo" unless File.exist?(source_file)

    if File.exist?(dest)
      FileUtils.remove_file(dest)
    end

    puts "Linking #{source_file} to #{dest}"
    FileUtils.ln_sf(source_file, dest)
  end

  def exec
    if @config['manage']
      if repo(@config['repo'])
        @config['files'].each do |k, v|
          link(k, v)
        end
      end
    end
  end
end
